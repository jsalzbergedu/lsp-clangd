;;; lsp-clangd.el --- clangd support for lsp-mode -*- lexical-binding: t; -*-

;; Copyright (C) 2017-2018 Thomas Brown <tabsoftwareconsulting@gmail.com>

;; Author: Thomas Brown <tabsoftwareconsulting@gmail.com>
;; Version: 3.1.2
;; Package-Requires: ((lsp-mode "3.0") (emacs "24.3"))
;; Keywords: lsp, clang, clangd, c, c++, objective-c, objective-c++
;; URL: https://github.com/emacs-lsp/lsp-clangd

;;; Commentary:

;;; The following Emacs Lisp will enable lsp-clangd after lsp-mode is
;;; loaded.
;;;
;;;    (with-eval-after-load 'lsp-mode
;;;      (require 'lsp-clangd)
;;;      (add-hook 'c-mode-hook #'lsp-clangd-c-enable)
;;;      (add-hook 'c++-mode-hook #'lsp-clangd-c++-enable)
;;;      (add-hook 'objc-mode-hook #'lsp-clangd-objc-enable))
;;;
;;; See `lsp-clangd-executable' to customize the path to clangd.

;;; Code:

(require 'lsp-mode)
(require 'lsp-common)

(defgroup lsp-clangd nil
  "Customization variables for lsp-clangd."
  :group 'tools)

(defcustom lsp-clangd-executable
  "clangd"
  "The clangd executable."
  :type 'string
  :group 'lsp-clangd)

(defvar-local lsp-clangd-launch-directory
  nil
  "If set, this variable is where clangd is started.")

(put 'lsp-clangd-launch-directory 'safe-local-variable #'stringp)

(defun lsp-clangd-make-traverser (filename)
  "Unless lsp-clangd-launch-directory is set, walk upward from the current directory to FILENAME.
Use lsp-clangd-executable to do so."
  (lambda () (or lsp-clangd-launch-directory
            (lsp-make-traverser filename))))

(lsp-define-stdio-client lsp-clangd-c++
                         "cpp"
                         (lsp-clangd-make-traverser "compile_commands.json")
                         (list lsp-clangd-executable)
                         :ignore-regexps
                         '("^Error -[0-9]+: .+$"))

(lsp-define-stdio-client lsp-clangd-c
                         "c"
                         (lsp-clangd-make-traverser "compile_commands.json")
                         (list lsp-clangd-executable)
                         :ignore-regexps
                         '("^Error -[0-9]+: .+$"))

(lsp-define-stdio-client lsp-clangd-objc
                         "objective-c"
                         (lsp-clangd-make-traverser "compile_commands.json")
                         (list lsp-clangd-executable)
                         :ignore-regexps
                         '("^Error -[0-9]+: .+$"))

(lsp-define-stdio-client lsp-clangd-objc++
                         "objective-cpp"
                         (lsp-clangd-make-traverser "compile_commands.json")
                         (list lsp-clangd-executable)
                         :ignore-regexps
                         '("^Error -[0-9]+: .+$"))

(provide 'lsp-clangd)

;;; lsp-clangd.el ends here
