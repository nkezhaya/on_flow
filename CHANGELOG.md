# Changelog

## 0.13.0

  * Updated Protobuf generated files
  * Replaced a call to `addPublicKey()` with `keys.add()` when creating a new
    account

## 0.12.0

  * Added `:metadata`, `:secure` config options. See `OnFlow.Channel`
    documentation.

## 0.11.0

  * Added `:gas_limit` options to transaction functions.

## 0.10.0

  * Introduced `TransactionResponse` struct to contain both the transaction as
    well as the response to the network call querying the transaction result.

## 0.9.0

  * Prepend transaction domain tag.

## 0.8.0

  * Significant performance improvement with the binary `copy_into/4` function.

## 0.7.0

  * Fixed a bug when generating an account keypair that had multiple leading
    `0x04` bytes

## 0.6.0

  * When waiting for sealed transactions, check the error field when returning
    `:ok` or `:error`
  * Fixed an issue with the rs pair not padding with null bytes appropriately
  * Moved `generate_keys/0` to `OnFlow.Crypto`

## 0.5.0

  * Bug fixes for the event decoder

## 0.4.0

  * Added event decoder
  * Decode events for transaction results
  * `OnFlow.Channel` now takes a host option directly

## 0.3.0

  * Added :connect_on_start config option

## 0.2.0

  * Fixed various dependency issues with installation

## 0.1.0

  * First version!
