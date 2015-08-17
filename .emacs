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
                        ;;  'flycheck
                        ;;  'projectile
                        ;;  'iedit
                            'auto-complete
                            'yasnippet
                            'helm
                        ;;  'perspective
                        ;;  'persp-projectile
                        ;;  'helm-projectile
                            'linum-relative
                            'magit)

; turn on evil mode 
(evil-mode t)

; show matching parenthesis
(show-paren-mode 1)

(global-linum-mode t)
(require 'linum-relative)

; yasnippet - tab key conflicts with evil mode
(require 'yasnippet)
(yas-global-mode 1)

; function aliases
(defalias 'hff 'helm-find-files)

; indentation style for c, c++, java
(setq c-default-style "linux"
      c-basic-offset 4)

; start emacs gui with full screen
(custom-set-variables
   '(initial-frame-alist (quote ((fullscreen . maximized)))))

; don't make backup files
(setq make-backup-files nil)

; gdb use many windows
;(setq gdb-many-windows t)
