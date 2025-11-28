# cv

My *Curriculum Vitae* made with LaTeX and using [`moderncv`](https://github.com/moderncv/moderncv).

## Installation

First, clone the repository.

```shell
$ git clone https://github.com/brtrndb/cv.git
```

## Dependencies

### Required

In order to build from source, make sure to have the following dependencies installed.

- The appropriate [LaTeX](https://www.latex-project.org/get/) distribution for your platform.
- The [`moderncv`](https://github.com/moderncv/moderncv) package to make this document look modern.
- The LaTeX compiler [`lualatex`](http://luatex.org/download.html). Feel free to use different one, but you may
  encounter some errors.

On Ubuntu, you can install required dependencies with this command:

```shell
$ sudo apt install \\
  texlive-luatex \\
  texlive-font-utils \\
  texlive-fonts-extra \\
  texlive-latex-extra \\
  texlive-lang-french
```

### Optional

To avoid typing long command lines for building, you can install:

- Make.
  ```shell
  $ sudo apt install make
  ```
- Or [JetBrains IntelliJ](https://www.jetbrains.com/idea/).
  ```shell
  $ sudo snap install intellij-idea-community --classic --edge
  ```

## Contents

```shell
$ tree -L 2 --gitignore --filesfirst -F
├── BertrandBoyer.pdf
├── BertrandBoyer.tex
├── LICENSE.md
├── Makefile
├── README.md
├── img/
│   ├── education/
│   ├── experiences/
│   ├── personal/
│   └── skills/
└── tex/
    ├── aliases.tex
    ├── community.tex
    ├── education.tex
    ├── experiences.tex
    ├── extra.tex
    ├── hobbies.tex
    ├── languages.tex
    ├── moderncv.tex
    ├── pageborder.tex
    ├── personal.tex
    ├── skills2.tex
    └── skills.tex
```

The files structure is quite simple:

- [`BertrandBoyer.pdf`](./BertrandBoyer.pdf) is the latest release of the document.
- [`BertrandBoyer.tex`](./BertrandBoyer.tex) is the main file. It defines main configuration and document structure, and
  links to other `.tex` files.
- [`img/`](./tex) directory contains images per section. There are two files per image `.xcf` to edit
  with [Gimp](https://www.gimp.org/), and its export as `.png`.
- [`tex/`](./tex) directory contains other `.tex` files. They separate content into smaller modules to ease readability.

## Build

### Using command line

The old-fashioned way to build document is to use `lualatex`.

```shell
$ lualatex --output-format=pdf BertrandBoyer.tex
```

You can use option `--interaction=batchmode` to hide unnecessary logs output.

### Using Makefile

You can build PDF using `make`.

Main targets are:

- `clean`: Clean up repository by deleting all temporary files.
- `fclean`: Clean up repository and delete the document.
- `re`: Clean up, delete and then rebuild the document.

### Using IntelliJ

An IntelliJ run configuration is present under [`.run/`](./.run). You can easily rebuild the document from one click
within your IDE.

Here are some tips that helps for LaTeX:

- Using [TeXiFy IDEA](https://plugins.jetbrains.com/plugin/9473-texify-idea) plugin.
- [File nesting](https://www.jetbrains.com/help/idea/file-nesting-dialog.html) association in project view.
    - `.tex` with `.aux`, `.log`, `.out`, `.pdf`, `.synctex.gz` to hide output files.
    - `.xcf` with `.jpeg`, `.jpg`, `.png`, `.svg`, to hide Gimp exports.

## Resources

- `moderncv` documentation: https://ctan.math.washington.edu/tex-archive/macros/latex/contrib/moderncv/manual/moderncv_userguide.pdf
- `fontawesome 5` documentation: https://mirrors.ircam.fr/pub/CTAN/fonts/fontawesome5/doc/fontawesome5.pdf
- `xargs` documentation: https://ctan.mines-albi.fr/macros/latex/contrib/xargs/xargs-fr.pdf

## Notes

Tested with Ubuntu.

```shell
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.3 LTS
Release:	22.04
Codename:	jammy
```

## License

See [LICENSE.md](./LICENSE.md)
