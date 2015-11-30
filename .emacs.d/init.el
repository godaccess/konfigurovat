(require 'generic-x)
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-mode))
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(require 'image)
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp/")))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path))) ;; Shadow
           (append 
            (copy-sequence (normal-top-level-add-to-load-path '(".")))
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))

;; OSX stuff.

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

 ;; keep OSX from opening more windows
(setq ns-pop-up-frames nil)


(progn (setq-default indent-tabs-mode nil) (setq c-default-style "ellemtel" c-basic-offset 2))
(load-theme 'monokai t)

;; key bindings for Darwin.
(when (eq system-type 'darwin) 
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)) ;; sets fn-delete to be right-delete

;; (set-face-background 'default "#F8F8F8")
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (prefer-coding-system 'utf-8)

(set-face-attribute 'mode-line nil
                    :foreground "DarkGray"
                    :box nil)

(set-face-attribute 'mode-line-inactive nil
                    :foreground "Gray"
                    :box nil)
;; (erc-hl-nicks-reset-face-table)

(require 'auto-complete-clang)

;; eshell stuff.

(require 'eshell)
(require 'em-smart)

(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

(if (fboundp 'scroll-bavr-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; Inhibit all startup messages

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

(column-number-mode t)  ;; And column numbers.

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
;; timestamps                                                                                     
(make-variable-buffer-local
 (defvar erc-last-datestamp nil))

(defun ks-timestamp (string)
  (erc-insert-timestamp-left string)
  (let ((datestamp (erc-format-timestamp (current-time) erc-datestamp-format)))
    (unless (string= datestamp erc-last-datestamp)
      (erc-insert-timestamp-left datestamp)
      (setq erc-last-datestamp datestamp))))

(setq erc-timestamp-only-if-changed-flag t
      erc-timestamp-format "%H:%M "
      erc-datestamp-format " === [%Y-%m-%d %a] ===\n" ; mandatory ascii art                          
      erc-insert-timestamp-function 'ks-timestamp
      erc-fill-prefix "      ↪ ")

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(eval-after-load 'haskell-mode
          '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(custom-set-variables '(haskell-tags-on-save t))
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
(custom-set-variables '(haskell-process-type 'cabal-repl))(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
  '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(require 'company)
(add-hook 'haskell-mode-hook 'company-mode)


(load "~/.emacs.d/defined-aliases")
(load "~/.emacs.d/erc")
(load "~/.emacs.d/globaladdhooks")
(load "~/.emacs.d/globalkey")
(load "~/.emacs.d/markdown-settings")
(load "~/.emacs.d/newsticker")
(load "~/.emacs.d/my-abbrevs")
(load "~/.emacs.d/my-defined-fuctions")
(load "~/.emacs.d/my-gitgutter")
(load "~/.emacs.d/my-helm")
(load "~/.emacs.d/my-ido")
(load "~/.emacs.d/my-flycheck")
(load "~/.emacs.d/my-ruby")
(load "~/.emacs.d/my-twit")
(load "~/.emacs.d/my-orgmode")
(load "~/.emacs.d/my-yas")
(load "~/.emacs.d/webjump")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" default)))
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services smiley stamp spelling track)))
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(org-agenda-files (quote ("~/org/emacs.org")))
 '(send-mail-function nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))

;; Show paren mode (http://www.emacswiki.org/emacs/ShowParenMode)
(show-paren-mode 1)
;; backup files because well backupfiles
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t
)
;; default to text mode
(setq-default major-mode 'text-mode)
;; blink instead of beep
(setq visible-bell t)

;; fixing up the scratch buffer
(setq initial-major-mode 'ruby-mode)
(setq initial-scratch-message "\
# This buffer is for notes you don't want to save, and for Ruby code.
# If you want to create a file, visit that file with C-x C-f,
# then enter the text in that file's own buffer.")

;; fix Warning(undo): Buffer Buffer list
(add-hook 'Buffer-menu-mode-hook 'buffer-disable-undo)

;; display date and time
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

;; highlight incremental search
(setq query-replace-highlight t)

;; make a larger buffer for M-x shell
(setq comint-buffer-maximum-size 10240)

;; add the column line mode
(setq column-number-mode t)

;; tack on flyspell to text
(add-hook 'text-mode-hook 'flyspell-mode)
(setq ispell-program-name "aspell"
  ispell-extra-args '("--sug-mode=ultra"))

;; Lorem-ipsum stuff
(autoload 'Lorem-ipsum-insert-paragraphs "lorem-ipsum" "" t)
(autoload 'Lorem-ipsum-insert-sentences "lorem-ipsum" "" t)
(autoload 'Lorem-ipsum-insert-list "lorem-ipsum" "" t)

;; convert from double space at the end of a sentance to single
(setq sentence-end-double-space nil)

;; auto centering
(setq
 scroll-conservatively 1000
 scroll-margin 0
 scroll-preserve-screen-position 1
 auto-window-vscroll nil)

(server-start) ;; so it's listening for the emacsclient alias
(setq ns-pop-up-frames nil) ;; keep OSX from opening more windows
;; 'y' instead of 'yes'
(fset 'yes-or-no-p 'y-or-n-p)
;; always use spaces, never tabs
(setq tab-width 2) ; set the tab width to two
;; skip startup message

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(set-face-attribute 'default nil
                    :family "Inconsolata"
                    :height 140
                    :weight 'normal
                    :width 'normal)



(require 'ansi-color)


(autoload 'ssh-config-mode "ssh-config-mode" t)
 (add-to-list 'auto-mode-alist '(".ssh/config\\'"       . ssh-config-mode))
 (add-to-list 'auto-mode-alist '("sshd?_config\\'"      . ssh-config-mode))
 (add-to-list 'auto-mode-alist '("known_hosts\\'"       . ssh-known-hosts-mode))
 (add-to-list 'auto-mode-alist '("authorized_keys2?\\'" . ssh-authorized-keys-mode))
 (add-hook 'ssh-config-mode-hook 'turn-on-font-lock)
