(load-file "./emacs-base/emacs")
;(customize-set-variable 'initial-buffer-choice (shell))
(global-set-key "\C-^"    'enlarge-window)
(global-set-key "\C-q"    'save-buffers-kill-emacs)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;THEME BEGIN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'emacs-startup-hook (lambda () (load-theme 'alect-black-alt t)))
;;;;;(load-theme 'alect-black-alt t)

;;for code snippets
(require 'yasnippet)

; also display column
(setq column-number-mode t)

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(defadvice shell (before advice-utf-shell activate)
  (set-default-coding-systems 'utf-8))
(ad-activate 'shell)

(prefer-coding-system 'utf-8)

; Renaming default shells (reason is next command)
(global-set-key [f5] (lambda () (interactive) (shell "*shell_1*")))
(global-set-key [f6] (lambda () (interactive) (shell "*shell_2*")))
(global-set-key [f7] (lambda () (interactive) (shell "*shell_3*")))


; Emacs 25 opens shell in a new window. Disabling it
(add-to-list 'display-buffer-alist
             '("^\\*shell_1\\*" . (display-buffer-same-window)))
(add-to-list 'display-buffer-alist
             '("^\\*shell_2\\*" . (display-buffer-same-window)))
(add-to-list 'display-buffer-alist
             '("^\\*shell_3\\*" . (display-buffer-same-window)))
(add-to-list 'display-buffer-alist
             '("^\\*cscope\\*" . (display-buffer-same-window)))

;(when (require 'undo-tree nil 'noerror)
;  (global-undo-tree-mode)
;  (global-set-key [(control ?\.)] 'undo-tree-redo)
;  )
;
(setq large-file-warning-threshold 200000000)

(defun my-shell-hook ()
  (local-set-key "\C-cl" 'erase-buffer))
(add-hook 'shell-mode-hook 'my-shell-hook)

(fset 'yes-or-no-p 'y-or-n-p) ; Change confirmation from yes to y

(global-superword-mode 1) ; Treat abc_def as one word for searches. C-s C-w would not highlight and search the word inclusive of underscore
(windmove-default-keybindings 'meta) ; Use Meta-<ARROW> keys to move between windows

(visit-tags-table "/home/dgautam/red/thk/dev/TAGS")

(add-hook 'emacs-startup-hook
          (lambda () (define-key global-map "\M-*" 'pop-tag-mark))
          (lambda () (delete-other-windows)) t)

;;;;;;;;;;;;;;AUTOCOMPLETE BEGIN;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; configure emacs-24 built-in cedet
(global-ede-mode 1)
(require 'semantic/sb)
(require 'semantic/ia)
(require 'srecode)

;; select which submodes we want to activate
(mapc (lambda (MODE) (add-to-list 'semantic-default-submodes MODE))
      '(global-semantic-mru-bookmark-mode
        global-semanticdb-minor-mode
        global-semantic-idle-scheduler-mode
        global-semantic-stickyfunc-mode
        global-semantic-highlight-func-mode
        global-semanticdb-minor-mode))

; Activate semantic
(semantic-mode 1)


;; customisation of modes
(mapc
 (lambda (MODE)
   (add-hook MODE
             (lambda ()
               (when (boundp 'semantic-ia-complete-symbol) (add-to-list 'completion-at-point-functions 'semantic-ia-complete-symbol))
               (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
               (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
               (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
               (local-set-key "\C-c=" 'semantic-decoration-include-visit)
               (local-set-key "\C-cj" 'semantic-ia-fast-jump)
               (local-set-key "\C-cq" 'semantic-ia-show-doc)
               (local-set-key "\C-cs" 'semantic-ia-show-summary)
               (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
               ))) '(c-mode-common-hook lisp-mode-hook emacs-lisp-mode-hook))

(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key "\C-ct" 'ff-find-other-file)
            (local-set-key "\C-c\C-r" 'semantic-symref)))

(semanticdb-enable-gnu-global-databases 'c-mode t)
(semanticdb-enable-gnu-global-databases 'c++-mode t)

;; SRecode
(global-srecode-minor-mode 1)

;; EDE
(global-ede-mode 1)
(ede-enable-generic-projects) ; Note: Having ~/.git causes errors.  Workaround: touch ~/.ede-ignore

(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key [tab] 'c-indent-line-or-region)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;AUTO COMPLETE END;;;;;;;;;;;;;;;;;;;;

(set-frame-font "Monospace-12")
(add-to-list 'default-frame-alist '(font . "Monospace-12"))
(set-default-font "Monospace-12")
(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(width . 80))
(balance-windows)

;(global-set-key "\C-M-b" 'balance-windows)
(global-set-key "\M-r" 'shell-resync-dirs)
(global-set-key "\C-c1"  'cscope-set-initial-directory)
(global-set-key "\C-c2"  'cscope-find-this-symbol)
(global-set-key "\C-c3"  'cscope-find-global-definition)
(global-set-key "\C-c4"  'cscope-find-this-text-string)
(global-set-key "\C-c5"  'cscope-find-this-file)
(global-set-key "\C-x\C-c" 'save-buffers-kill-emacs)
(global-set-key [f9] (lambda () (interactive) (switch-to-buffer "*cscope*")))
(global-set-key "\M-g"    'find-file-at-point)
(put 'erase-buffer 'disabled nil)

(cscope-set-initial-directory "/home/dgautam/red/thk/dev/")
;matching parenthesis
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key "%" 'match-paren)

(add-hook 'comint-mode-hook
  (lambda ()
    (define-key comint-mode-map (kbd "M-p") 'comint-previous-matching-input-from-input)
    (define-key comint-mode-map (kbd "M-n") 'comint-next-matching-input-from-input)))
(global-auto-revert-mode t)

(setq x-select-enable-clipboard t)
(setq interprogram-pase-function 'x-cut-buffer-or-selection-value)

(require 'dirtrack)
(defun my-dir-track-mode ()
  (dirtrack-mode 0)
  (setq dirtrack-list '("\\(?:[0-9][0-9]:\\)\\{3\\}dgautam@.*?:\\(.*?\\):" 1 nil)) ; Matches: 11:09:33:jhwest@sjoth256-1:/data3/jhwest/work/thk: (master)>
                                                                                  ; Change the regex to match your prompt
  (dirtrack-mode 1))
(add-hook 'comint-mode-hook 'my-dir-track-mode)

(when (require 'magit nil 'noerror)) ; Load magit if it can be found

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

(require 'bind-key)
(bind-key* "\M-*" 'pop-tag-mark)

;; Suggest file names as you type, buffers as you load
;; ido
(progn
  (require 'ido)
  ;; make buffer switch command do suggestions, also for find-file command
  (ido-mode 1)
  ;; (ido-everywhere 1)
  (if ; make ido display choices vertically
      (version< emacs-version "25")
      (progn
        (make-local-variable 'ido-separator)
        (setq ido-separator "\n"))
    (progn
      (make-local-variable 'ido-decorations)
      (setf (nth 2 ido-decorations) "\n")))
  (setq ido-enable-flex-matching t) ; show any name that has the chars you typed
  (setq ido-default-file-method 'selected-window) ; use current pane for newly opened file
  (setq ido-default-buffer-method 'selected-window) ; use current pane for newly switched buffer
  (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil) ; stop ido from suggesting when naming new file
  )


(require 'zone)
(zone-when-idle 560)
(global-set-key (kbd "C-c m") 'mc/edit-lines)
(require 'gear-ext)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(comint-completion-addsuffix t)
 '(comint-input-ignoredups t)
 '(comint-scroll-show-maximum-output t)
 '(compilation-search-path (quote (".")))
 '(current-language-environment "Latin-9")
 '(default-input-method "latin-9-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(package-selected-packages
   (quote
    (multiple-cursors yasnippet use-package solarized-theme monokai-theme magit company-irony-c-headers company-irony auto-complete-c-headers alect-themes ac-c-headers)))
 '(show-paren-mode t nil (paren)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "white")))))
