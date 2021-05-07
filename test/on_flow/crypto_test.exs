defmodule OnFlow.CryptoTest do
  use OnFlow.DataCase
  import OnFlow.Crypto

  test "rs pair null bytes" do
    signature =
      <<48, 69, 2, 33, 0, 207, 110, 198, 85, 44, 145, 102, 222, 232, 244, 32, 103, 87, 23, 199,
        60, 196, 248, 198, 180, 72, 221, 239, 27, 163, 96, 97, 104, 200, 60, 44, 26, 2, 32, 0,
        228, 52, 215, 209, 2, 78, 60, 83, 217, 202, 229, 164, 54, 104, 167, 140, 69, 188, 156,
        113, 207, 159, 136, 139, 82, 190, 248, 44, 228, 242, 8>>

    assert encode16(rs_pair(signature)) ==
             "cf6ec6552c9166dee8f420675717c73cc4f8c6b448ddef1ba3606168c83c2c1a00e434d7d1024e3c53d9cae5a43668a78c45bc9c71cf9f888b52bef82ce4f208"
  end

  test "copy into" do
    bin = <<0, 0, 0, 0, 0, 0, 0, 0>>

    assert copy_into(bin, <<2, 3>>) == <<2, 3, 0, 0, 0, 0, 0, 0>>
    assert copy_into(bin, <<2, 3>>, 1) == <<0, 2, 3, 0, 0, 0, 0, 0>>
    assert copy_into(bin, <<2, 3>>, 0, 1) == <<3, 0, 0, 0, 0, 0, 0, 0>>
    assert copy_into(bin, <<2, 3>>, 1, 1) == <<0, 3, 0, 0, 0, 0, 0, 0>>
  end
end
