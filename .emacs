; start package.el with emacs
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
; initialize package.el
(package-initialize)

; set neotree
(require 'neotree)
(add-to-list 'load-path' "/home/dplee/.emacs.d/elpa/neotree-20150726.636/")
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
