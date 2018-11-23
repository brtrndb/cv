# moderncv

My CV with LaTeX moderncv template.

## Installation

First, clone the repository.

```sh
$ git clone https://github.com/brtrndb/moderncv.git
```

## Requirements

Then install all LaTeX dependencies.

```sh
$ sudo apt-get install texlive-luatex texlive-font-utils texlive-fonts-extra texlive-latex-extra texlive-lang-french
```

## Usage

Finally, make it.

```sh
$ make
```

Or, you can use the `cv.sh` script.

```sh
$ ./cv.sh
Usage: ./cv.sh
-o, --output:  Output file name. Default: BertrandBoyer.pdf.
-i, --images:  Set images. Options: all, profile, education, experiences, sections. Default: sections.
--personal:    Use/Don't use the Personal Informations section. Default: true.
--education:   Use/Don't use the Education section. Default: true.
--experiences: Use/Don't use the Experiences section. Default: true.
--skills:      Use/Don't use the Skills section. Default: true.
--languages:   Use/Don't use the Language section. Default: true.
--hobbies:     Use/Don't use the Hobbies section. Default: true.
--no-reset:    After generating BertrandBoyer.pdf, don't reset 'BertrandBoyer.tex' to its previous git state.
-h, --help:    Display usage.
```

## Notes

## License

See [LICENSE.md](./LICENSE.md)
