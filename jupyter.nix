{ pkgs, ... }:

{
  services.jupyter = {
    enable = true;
    password = "'sha1:22d45a0053ec:6742a70fb1a2ed08719e16819394fc8c7cef4633'";
    kernels = {
      #haskell = let 
      #  ihaskellEnv = pkgs.haskellPackages.ghcWithPackages (self: [
      #  self.ihaskell
      #  #(pkgs.haskell.lib.doJailbreak self.ihaskell-blaze)
      #  #(pkgs.haskell.lib.doJailbreak self.ihaskell-diagrams)
      #  #(pkgs.haskell.lib.doJailbreak self.ihaskell-display)
      #  ]);

      #  ihaskellSh = pkgs.writeScript "ihaskell-wrapper" ''
      #    #! ${pkgs.stdenv.shell}
      #    export GHC_PACKAGE_PATH="$(echo ${ihaskellEnv}/lib/*/package.conf.d| tr ' ' ':'):$GHC_PACKAGE_PATH"
      #    export PATH="${pkgs.stdenv.lib.makeBinPath ([ ihaskellEnv ])}''${PATH:+:}$PATH"
      #    ${ihaskellEnv}/bin/ihaskell ''$@
      #  '';
      #in {
      #  displayName = "Haskell for machine learning";
      #  # https://github.com/gibiansky/IHaskell/issues/920
      #  argv = [
      #    "${ihaskellSh}"
      #    "kernel"
      #    "{connection_file}"
      #    "--ghclib"
      #    "${ihaskellEnv}/lib/ghc-8.4.3"
      #    "+RTS"
      #    "-M3g"
      #    # "-N2" # requires the program to be compiled with threaded
      #    "-RTS"
      #  ];
      #  language = "haskell";
      #};
      python3 = let
          env = (pkgs.python3.withPackages (python3Packages: with python3Packages; [
                    ipykernel
                    pandas
                    scikitlearn
                    matplotlib
                    # Quandl -- fails?
                  ]));
          in {
            displayName = "Python 3 for Data Science";
            argv = [
              "${env}/bin/python"
              "-m"
              "ipykernel_launcher"
              "-f"
              "{connection_file}"
            ];
            language = "python";
            #logo32 = "${env.sitePackages}/ipykernel/resources/logo-32x32.png";
            #logo64 = "${env.sitePackages}/ipykernel/resources/logo-64x64.png";
          };
    };
  };
}
