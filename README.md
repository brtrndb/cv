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

## cv.sh

This script allows to generates different versions of my CV.
I admit it. It is not really useful to have a script.
But now I don't have to alway modify all `.tex` files.
And most important, it was fun ;)

### Options

* `-n` or `--name`: Set the name of the output pdf.
* `-l` or `--language`: Set the language of the CV (French or English). English translation is not yet complete.
* `-b` or `--bertrand`: Display header of the CV with name and contact infos.
* `-i` or `--images`: Display images in the CV (school and company logos).
* `-m` or `--missions`: Display missions section.
* `-p` or `--projects`: Display projects section.

### Infos

When the script runs, it modifies the file `BertrandBoyer.tex`. When the script ends, the `.tex` is restorated to its default state.

## Notes

## License

See [LICENSE.md](./LICENSE.md)
