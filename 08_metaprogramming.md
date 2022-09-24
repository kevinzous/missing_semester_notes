# Metaprogramming

## Exercises

 1. Most makefiles provide a target called `clean`. This isn't intended
    to produce a file called `clean`, but instead to clean up any files
    that can be re-built by make. Think of it as a way to "undo" all of
    the build steps. Implement a `clean` target for the `paper.pdf`
    `Makefile` above. You will have to make the target
    [phony](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html).
    You may find the [`git
    ls-files`](https://git-scm.com/docs/git-ls-files) subcommand useful.
    A number of other very common make targets are listed
    [here](https://www.gnu.org/software/make/manual/html_node/Standard-Targets.html#Standard-Targets).

```bash
paper.pdf: paper.tex plot-data.png
	pdflatex paper.tex

plot-%.png: %.dat plot.py
	./plot.py -i $*.dat -o $@

.PHONY: clean
clean:
	rm plot-data.png paper.log paper.aux paper.pdf

.PHONY : install
install:
	# https://gist.github.com/rain1024/98dd5e2c6c8c28f9ea9d
	sudo apt-get install -y texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
	pip install matplotlib
```

 2. Take a look at the various ways to specify version requirements for
    dependencies in [Rust's build system](https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html).
    Most package repositories support similar syntax. For each one
    (caret, tilde, wildcard, comparison, and multiple), try to come up
    with a use-case in which that particular kind of requirement makes
    sense.

```toml
# cargo.toml
[package]
name = "my-package"
version = "0.1.0"

[dependencies]
time = "0.1.12"          # does not change left most non zero digits
                         # 0.1.12 := >=0.1.12, <0.2.0

openssl = "^1.0.1"       # caret = exact version

regex = "~0.1"           # tilde = minimal version with some ability to update
                         # ~0.1 := >=0.1.0, <0.2.0

python = "3.*"            # wildcard : any version allowed by wildcard

regex = ">= 1.2.0"       # comparison

regex = ">= 1.2, < 1.5"  # multiple
```

 3. Git can act as a simple CI system all by itself. In `.git/hooks`
    inside any git repository, you will find (currently inactive) files
    that are run as scripts when a particular action happens. Write a
    [`pre-commit`](https://git-scm.com/docs/githooks#_pre_commit) hook
    that runs `make paper.pdf` and refuses the commit if the `make`
    command fails. This should prevent any commit from having an
    unbuildable version of the paper.

```bash
## add following in .git/pre-commit
if ! make; then
	echo "Error : build failed, commit aborted"
	exit 1
fi
```

 4. Set up a simple auto-published page using [GitHub Pages](https://pages.github.com/).
    Add a [GitHub Action](https://github.com/features/actions) to the repository to run `shellcheck` on any shell
    files in that repository (here is [one way to do it](https://github.com/marketplace/actions/shellcheck)). Check that it works!


1- create github.io repo
2- add following in .github/workflows/github-actions.yml

```yaml
# .github/workflows/github-actions.yml
on: push
name: "Trigger: Push"
jobs:
  shellcheck:
    name: Shellcheck
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run ShellCheck
        uses: ludeeus/action-shellcheck@master
```

 5. [Build your own](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/building-actions) GitHub action to run [`proselint`](http://proselint.com/) or [`write-good`](https://github.com/btford/write-good) on all the
    `.md` files in the repository. Enable it in your repository, and
    check that it works by filing a pull request with a typo in it.

```yml
on: push
name: "Trigger: Push"
jobs:
    name: lint Markdown files
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: write-good action step
        id: write-good
        uses: tomwhross/write-good-action@v1.5
      # Use the output from the `write-good` step
      - name: Get the write-good output
        run: echo "${{ steps.write-good.outputs.result }}"
      - name: Post comment
        uses: mshick/add-pr-comment@v1
        if: ${{ steps.write-good.outputs.result }}
        with:
          message: |
            ${{ steps.write-good.outputs.result }}
          repo-token: ${{ secrets.GITHUB_TOKEN }}
          repo-token-user-login: 'github-actions[bot]' # The user.login for temporary GitHub tokens
          allow-repeats: false # This is the default

  pyflakes:
      name: Python Lint
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v2
        - uses: actions/setup-python@v2
          with:
            python-version: "3.9"
        - name: Run flake8
          uses: julianwachholz/flake8-action@v2
          with:
            checkName: "Python Lint"
            # path: path/to/files
            plugins: flake8-spellcheck
            # config: path/to/flake8.ini
          env:
            GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
