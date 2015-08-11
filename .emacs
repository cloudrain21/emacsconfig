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
                            'flycheck
                            'projectile
                            'iedit
                            'auto-complete
                            'yasnippet
                            'helm
                            'perspective
                            'persp-projectile
                            'helm-projectile
                            'magit)

(evil-mode t)
(yas-global-mode 1)
(global-linum-mode t)
(show-paren-mode 1)

(persp-mode)
(require 'persp-projectile)
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)
(define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)
(helm-projectile-on)
