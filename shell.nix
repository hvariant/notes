with import <nixpkgs> {};
mkShell {
  name = "github-pages";
  buildInputs = [ mdbook ];
}
