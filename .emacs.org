; load theme
(load-theme 'misterioso)

; package archives
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

; load-path
(add-to-list 'load-path '"/home/dplee/.emacs.d/elpa/el-autoyas-20120918.617")
(add-to-list 'load-path '"/home/dplee/.emacs.d/elpa/el-swank-fuzzy-20130824.1157/")
(add-to-list 'load-path '"/home/dplee/.emacs.d/elpa/el-spice-20140805.1138/")
(add-to-list 'load-path '"/home/dplee/.emacs.d/elpa/neotree-20150726.636/")

; set neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle) 

; start auto-completion with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

; let's define a function which initializes auto-complete-c-headers 
; and gets called for c/c++ hooks
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

; turn on Semantic after installing cedet package
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

; turn on ede mode
(global-ede-mode 1)
; create a project for our program
(ede-cpp-root-project "goldilocks" :file "~/work/3rd_iter_trunk/src/goldilocks/src/dbm/dbmAPI/dbmInitHandle.cpp"
		      :include-path '("/home/dplee/work/3rd_iter_trunk/src/goldilocks/header"))
; you can use system-include-path for setting up the system header file locations

; When you can't execute package-list-packages without this.
; It's for security.
(setq gnutls-min-prime-bits 1024)

(require 'el-autoyas)
(el-autoyas-enable)
(require 'el-swank-fuzzy)
(require 'el-spice)

; show line number
(global-linum-mode t)

; show parenthesis highlighting
(show-paren-mode 1)

; copy & cut line or region -> paste
(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
   When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').
   URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
   Version 2015-05-06"
  (interactive)
  (let (&p1 &p2)
    (if current-prefix-arg
        (progn (setq &p1 (point-min))
               (setq &p2 (point-max)))
        (progn (if (use-region-p)
                 (progn (setq &p1 (region-beginning))
                        (setq &p2 (region-end)))
                 (progn (setq &p1 (line-beginning-position))
                        (setq &p2 (line-end-position))))))
    (kill-ring-save &p1 &p2)
    (if current-prefix-arg
        (message "buffer text copied")
        (message "text copied"))))

(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
   When `universal-argument' is called first, cut whole buffer (respects `narrow-to-region').
   URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
   Version 2015-06-10"
  (interactive)
  (if current-prefix-arg
      (progn ; not using kill-region because we don't want to include previous kill
        (kill-new (buffer-string))
        (delete-region (point-min) (point-max)))
      (progn (if (use-region-p)
               (kill-region (region-beginning) (region-end) t)
               (kill-region (line-beginning-position) (line-beginning-position 2))))))

(global-set-key (kbd "<f2>") 'xah-cut-line-or-region)
(global-set-key (kbd "<f3>") 'xah-copy-line-or-region)
(global-set-key (kbd "<f4>") 'yank)

; for helm
(require 'helm-config)
(require 'helm)

; buffer manipulation
(require 'buffer-utils)
(buffer-utils-save-order
    (bury-buffer "*scratch*"))

; this is git test
