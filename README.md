# lsp-clangd

A configuration for an Emacs LSP client for Clang-based languages
using [`clangd`](https://clang.llvm.org/extra/clangd.html) as the
language server.

Note that `clangd` is still a work-in-progress.  See the recent
[commits](https://github.com/llvm-mirror/clang-tools-extra/commits/master/clangd).
It is highly recommended that you run the latest version of `clangd`
to get the best behavior.

## Requirements

* [`clangd`](https://clang.llvm.org/extra/clangd.html)
* [`lsp-mode`](https://github.com/emacs-lsp/lsp-mode)

## Installing `clangd`

Since `clangd` is part of `clang-tools-extra` since Clang 5, it can be
installed by all the same methods for installing Clang 5 or later.

With macOS, the easiest way is to install via Homebrew.  Note that
this recipe is keg-only, so you must customize `lsp-clangd-executable`
to `/usr/local/opt/llvm/bin/clangd`.

``` shell
brew install llvm --HEAD
```

## Enabling `lsp-clangd`

`lsp-clangd` is available from MELPA.

By default, `lsp-clangd` searches for `clangd` on the executable
search path.  The location of `clangd` can be changed by customizing
the variable `lsp-clang-executable`.

### Using standard Emacs Lisp

Install `lsp-mode` via some suitable method and clone this repository
to a suitable path, *e.g.* `<path-to-lsp-clangd>`.

The following Emacs Lisp will enable lsp-clangd after lsp-mode is
loaded.

``` emacs-lisp
(add-to-list 'load-path "<path-to-lsp-clangd>")

(with-eval-after-load 'lsp-mode
  (require 'lsp-clangd)
  (add-hook 'c-mode-hook #'lsp-clangd-c-enable)
  (add-hook 'c++-mode-hook #'lsp-clangd-c++-enable)
  (add-hook 'objc-mode-hook #'lsp-clangd-objc-enable))
```

See `lsp-clangd-executable` to customize the path to clangd.


### Using `use-package`

``` emacs-lisp
(use-package lsp-clangd
  :load-path
  "<path-to-lsp-clangd>"
  :hook
  ((c-mode . lsp-clangd-c-enable)
   (c++-mode . lsp-clangd-c++-enable)
   (objc-mode . lsp-clangd-objc-enable)))
```

### Advanced Configuration

The following configuration customizes the location of the `clangd`
executable for macOS.

``` emacs-lisp
(use-package lsp-clangd
  :load-path
  "<path-to-lsp-clangd>"
  :init
  (when (equal system-type 'darwin)
    (setq lsp-clangd-executable "/usr/local/opt/llvm/bin/clangd"))

  (add-hook 'c-mode-hook #'lsp-clangd-c-enable)
  (add-hook 'c++-mode-hook #'lsp-clangd-c++-enable)
  (add-hook 'objc-mode-hook #'lsp-clangd-objc-enable))
```
