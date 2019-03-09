1. copy .emacs file into your home directory
2. Run emacs.
   24.4 or later version of emacs is recommanded.
   (to build emacs ./compile-emacs.sh)
3. Type 'y' for every questions about installing packages.

You can use evil mode, yasnippet, auto complete, relative line number, etc.
Refer to the package list to be installed in .emacs file.

ggtags-find-file is too slow because of the execution of 'global -u'.
You should comment (ggtags-update-tags) function call, in ggtags-read-tag function.
Instead, you should run ggtags in your gtags top directory whenever you modify some files.

 857 (defun ggtags-read-tag (&optional type confirm prompt require-match default)
 858   (ggtags-ensure-project)
 859   (let ((default (or default (ggtags-tag-at-point)))
 860         (prompt (or prompt (capitalize (symbol-name (or type 'tag)))))
 861         (ggtags-completion-flag (pcase type
 862                                   (`(or nil definition) "T")
 863                                   (`symbol "s")
 864                                   (`reference "r")
 865                                   (`id "I")
 866                                   (`path "P")
 867                                   ((pred stringp) type)
 868                                   (_ ggtags-completion-flag))))
 869     (setq ggtags-current-tag-name
 870           (cond (confirm
 871                  ;; dplee (ggtags-update-tags)   <======= here
 872                  (let ((completing-read-function
 873                         (or ggtags-completing-read-function
 874                             completing-read-function)))
 875                    (completing-read
 876                     (format (if default "%s (default %s): " "%s: ") prompt default)
 877                     ggtags-completion-table nil require-match nil nil default)))
 878                 (default (substring-no-properties default))
 879                 (t (ggtags-read-tag type t prompt require-match default))))))

