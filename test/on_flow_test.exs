defmodule OnFlowTest do
  use ExUnit.Case

  import OnFlow.{Transaction, Util}
  alias OnFlow.Crypto

  setup do
    script = "import 0xsomething \n {}"
    arguments = [<<2, 2, 3>>, <<3, 3, 3>>]
    authorizers = [<<9, 9, 9, 9, 9>>, <<8, 9, 9, 9, 9>>]

    proposal_key =
      Flow.Entities.Transaction.ProposalKey.new(%{
        address: <<4, 5, 4, 5, 4, 5>>,
        key_id: 11,
        sequence_number: 7
      })

    payer = <<6, 5, 4, 3, 2>>
    gas_limit = 44
    reference_block_id = <<3, 3, 3, 6, 6, 6>>

    transaction =
      Flow.Entities.Transaction.new(%{
        script: script,
        arguments: arguments,
        authorizers: authorizers,
        proposal_key: proposal_key,
        payer: payer,
        gas_limit: gas_limit,
        reference_block_id: reference_block_id
      })

    [transaction: transaction]
  end

  test "canonical forms", %{transaction: transaction} do
    payload_expected_hex =
      "f86a97696d706f7274203078736f6d657468696e67200a207b7dc88302020383030303a000000000000000000000000000000000000000000000000000000303030606062c8800000405040504050b07880000000605040302d2880000000909090909880000000809090909"

    assert encode16(payload_canonical_form(transaction)) == payload_expected_hex

    # Test the envelope
    foo_signature =
      Flow.Entities.Transaction.Signature.new(%{
        key_id: 0,
        signature: <<4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4>>
      })

    bar_signature =
      Flow.Entities.Transaction.Signature.new(%{
        key_id: 5,
        signature: <<3, 3, 3>>
      })

    transaction = %{transaction | payload_signatures: [foo_signature, bar_signature]}

    # I changed a 0x04 byte to 0x01 here because the Kotlin test I copied this
    # from is specifying an incorrect index, and OnFlow generates the indexes
    # programmatically.
    envelope_expected_hex =
      "f883f86a97696d706f7274203078736f6d657468696e67200a207b7dc88302020383030303a000000000000000000000000000000000000000000000000000000303030606062c8800000405040504050b07880000000605040302d2880000000909090909880000000809090909d6ce80808b0404040404040404040404c6010583030303"

    assert encode16(envelope_canonical_form(transaction)) == envelope_expected_hex
  end

  test "hash and sign", %{transaction: transaction} do
    foo_signature =
      Flow.Entities.Transaction.Signature.new(%{
        key_id: 0,
        signature: <<4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4>>
      })

    bar_signature =
      Flow.Entities.Transaction.Signature.new(%{
        key_id: 5,
        signature: <<3, 3, 3>>
      })

    transaction = %{transaction | payload_signatures: [foo_signature, bar_signature]}

    # ECDSA P256, hash is SHA3-256
    private_key = decode16("ceff2bd777f3b5c81d7edfd191c99239cb9c56fc64946741339a55fd094586c9")

    payload_canonical_form = payload_canonical_form(transaction)
    payload_signature = Crypto.sign(payload_canonical_form, private_key)
    assert payload_signature

    envelope_canonical_form = envelope_canonical_form(transaction)
    envelope_signature = Crypto.sign(envelope_canonical_form, private_key)
    assert envelope_signature
  end

  test "rlp without arguments" do
    address = "fe94371aaeff5c51"

    script =
      decode16(
        "7472616e73616374696f6e2829207b0a202065786563757465207b0a202020206c6f67282248656c6c6f2c20576f726c642122290a20207d0a7d"
      )

    arguments = []

    reference_block_id =
      decode16("dd0b3378ab23b3eb1cb5c1f8b55f6ed152632082c76e7d2bffc4354e2ef32fd3")

    gas_limit = 1000

    proposal_key =
      Flow.Entities.Transaction.ProposalKey.new(%{
        address: decode16(address),
        key_id: 0,
        sequence_number: 0
      })

    payer = decode16(address)
    authorizers = [decode16(address)]

    transaction =
      Flow.Entities.Transaction.new(%{
        script: script,
        arguments: arguments,
        authorizers: authorizers,
        proposal_key: proposal_key,
        payer: payer,
        gas_limit: gas_limit,
        reference_block_id: reference_block_id
      })

    rlp = envelope_canonical_form(transaction)

    assert rlp ==
             decode16(
               "f882f87fb83a7472616e73616374696f6e2829207b0a202065786563757465207b0a202020206c6f67282248656c6c6f2c20576f726c642122290a20207d0a7dc0a0dd0b3378ab23b3eb1cb5c1f8b55f6ed152632082c76e7d2bffc4354e2ef32fd38203e888fe94371aaeff5c51808088fe94371aaeff5c51c988fe94371aaeff5c51c0"
             )
  end

  test "rs pair" do
    pairs = [
      {"3046022100adc325fc98b758737393595645baa89017b214890bd633ae73bd79b8c8d1c26a022100f948b523e9a2f80ad97c389d19ec2b2a855ae8a36275b544debf182c4ab22dad",
       "adc325fc98b758737393595645baa89017b214890bd633ae73bd79b8c8d1c26af948b523e9a2f80ad97c389d19ec2b2a855ae8a36275b544debf182c4ab22dad"},
      {"3045022031c59fed2fab22ff10f5ec1194a283dc4519ac10dc2671587466660f5c751f77022100eaa3330893c3eb42d4e53c25fefda13e59b092841628798a178c1992df81771c",
       "31c59fed2fab22ff10f5ec1194a283dc4519ac10dc2671587466660f5c751f77eaa3330893c3eb42d4e53c25fefda13e59b092841628798a178c1992df81771c"}
    ]

    for {signature, expected} <- pairs do
      assert encode16(Crypto.rs_pair(decode16(signature))) == expected
    end
  end
end
