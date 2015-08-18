; theme
(load-theme 'tango-dark)

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Assuming you wish to install packages
(ensure-package-installed   'evil
                            'evil-surround
                        ;;  'flycheck
                        ;;  'projectile
                        ;;  'iedit
                            'auto-complete
                            'ac-c-headers
                            'yasnippet
                            'helm
                        ;;  'perspective
                        ;;  'persp-projectile
                        ;;  'helm-projectile
                            'linum-relative
                            'magit)

; turn on evil mode 
(evil-mode t)

; evil-surround
; surrounding?
; see http://www.vim.org/scripts/script.php?script_id=1697
(require 'evil-surround)
(global-evil-surround-mode 1)

; show matching parenthesis
(show-paren-mode 1)

(global-linum-mode t)
(require 'linum-relative)

; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"
                         "~/.emacs.d/remote-snippets"))
(yas-reload-all)
; (define-key yas-minor-mode-map (kbd "<tab>") nil)
; (define-key yas-minor-mode-map (kbd "TAB") nil)
; (setq tab-always-indent 'yas-expand)
; (define-key yas-minor-mode-map (kbd "C-l") 'yas-expand)
(define-key yas-minor-mode-map (kbd "<escape>") 'yas-exit-snippet)

; helm
(setq helm-buffers-fuzzy-matching t)
(helm-mode 1)
(defalias 'hff 'helm-find-files)

; indentation style for c, c++, java
(setq c-default-style "linux"
      c-basic-offset 4)

; start emacs gui with full screen
(custom-set-variables
   '(initial-frame-alist (quote ((fullscreen . maximized)))))

; don't make backup files
(setq make-backup-files nil)

; auto complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

; add semantic to autocomplete
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
(global-ede-mode 1)

; gdb use many windows
;(setq gdb-many-windows t)
