{ mkDerivation, aeson, async, attoparsec, base, blaze-colonnade
, blaze-html, bytestring, cassava, cereal, Chart, Chart-diagrams
, colonnade, connection, containers, criterion, dec, deepseq
, directory, doctest, exceptions, extra, filepath, fin, fingertree
, fmt, haskell-src-exts, haskell-src-meta, hedgehog, hint, hpack
, http-client, lens, lib, monad-logger, mtl, network
, network-simple, optparse-applicative, random, req, resourcet
, servant-blaze, servant-server, singletons, split, stm, stm-chans
, streaming, streaming-bytestring, streaming-utils, tasty
, tasty-golden, tasty-hedgehog, tasty-hspec, template-haskell, text
, text-show, time, timeit, transformers, unix-compat, warp
}:
mkDerivation {
  pname = "hid-examples";
  version = "0.5";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    base bytestring cereal connection exceptions fingertree
    haskell-src-exts haskell-src-meta hedgehog mtl network
    network-simple split template-haskell text-show-
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson async attoparsec base blaze-colonnade blaze-html bytestring
    cassava cereal Chart Chart-diagrams colonnade containers dec
    directory exceptions extra filepath fin fmt hedgehog http-client
    lens monad-logger mtl optparse-applicative random req resourcet
    servant-blaze servant-server singletons stm stm-chans streaming
    streaming-bytestring streaming-utils template-haskell text
    text-show time timeit transformers unix-compat warp
  ];
  testHaskellDepends = [
    base doctest filepath hedgehog hint random split tasty tasty-golden
    tasty-hedgehog tasty-hspec text text-show
  ];
  benchmarkHaskellDepends = [ base criterion deepseq ];
  doHaddock = false;
  prePatch = "hpack";
  homepage = "https://github.com/bravit/hid-examples#readme";
  description = "Examples to accompany the book \"Haskell in Depth\"";
  license = lib.licenses.bsd3;
}
