# Lean4 Project Template

This is a template for a [Lean4](https://lean-lang.org/) project, that includes a 
setup of Lean4 itself, [mathlib](https://github.com/leanprover-community/mathlib4), 
and [lean blueprints](https://github.com/PatrickMassot/leanblueprint).

It is an opinionated template, it might not fit every use case. Its main goal is to
provide an easy starting point for having a project with blueprints, where the only 
dependency is an installation of [Nix](https://nixos.org/). It is tested on Linux 
and MacOS (it is **not tested** on Windows).

## Using the generator

0. Ensure you have a running installation of `nix` (an easy way to install it is using
   this [installer](https://determinate.systems/nix-installer/)).
1. Generate a project by running:
   ```shell
   nix run github:provables/lean4-template DEST_DIR
   ```
   where `DEST_DIR` is a directory of your choice.

## Using the generated project

The generator creates a Lean4 project in `DEST_DIR/<my-project-name>`. It is a standard
`lake` project, where you can use your standard installation of Lean4. However, the
project also includes a Nix flake that can spawn a development environment which
includes:

- an installation of Lean4 (using the standard `elan`, so it should respect any
  pre-existing installation),
- `leanblueprint`, with the necessary dependencies to generate the web and pdf docs,
- a simple task manager configured for building the project, the docs, and the
  blueprints.

For using the development environment, run:
```shell
cd DEST_DIR/<my-project-name>
nix develop
```
Once in the environment, you can run `lake`, `leanblueprint`, etc. You can also use
the task manager `task`. For example:
```shell
$ task build       # builds the project
$ task serve-page  # builds the blueprints and serves the page in `localhost`
$ task -a          # show all tasks available
```
The task manager ensures `mathlib` cache is available, and in general tries to minimize
the work for every step.

## TODO

- Allow updating the generated project when the template gets updated.
- Allow specifying the `lean-toolchain` (currently hard-coded to 4.15).

# License

MIT


   