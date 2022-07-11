(hall-description
  (name "political-conformance-test")
  (prefix "")
  (version "0.2")
  (author "James Crake-Merani")
  (copyright (2022))
  (synopsis "")
  (description
    "A program to test the conformance of the user to particular political ideology")
  (home-page "https://github.com/jamescrake-merani/political-conformance-test")
  (license gpl3+)
  (dependencies `())
  (skip ())
  (files (libraries
           ((directory
              "political-conformance-test"
              ((scheme-file "interactive-console")
               (scheme-file "operations")))))
         (tests ((directory "tests" ())))
         (programs
           ((directory "scripts" ((in-file "pct")))))
         (documentation
           ((org-file "README")
            (symlink "README" "README.org")
            (directory
              "doc"
              ((texi-file "political-conformance-test")))
            (text-file "NEWS")
            (text-file "AUTHORS")
            (text-file "COPYING")))
         (infrastructure
           ((scheme-file "guix")
            (scheme-file "hall")
            (directory
              "build-aux"
              ((text-file "missing")
               (tex-file "texinfo")
               (scheme-file "test-driver")
               (text-file "install-sh")))
            (in-file "pre-inst-env")))))
