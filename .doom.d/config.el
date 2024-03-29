;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Steph Samson"
      user-mail-address "hello@stephsamson.com"
      display-line-numbers-type t
      doom-theme 'doom-ayu-light
      doom-font (font-spec :family "JetBrains Mono" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 15)
      fill-column 79)

;; (use-package! autothemer)
;; (straight-use-package
;;  '(rose-pine-emacs
;;    :host github
;;    :repo "thongpv87/rose-pine-emacs"
;;    :branch "master"))

;; (load-theme 'rose-pine-moon t)

(exec-path-from-shell-initialize)

;; org and family
;;
(setq org-directory "~/Documents/org/"
      org-log-done 'time
      org-roam-directory (file-truename "~/Documents/org/roam/")
      org-roam-db-gc-threshold most-positive-fixnum
      org-startup-with-inline-images t)

(after! org
  (setq org-agenda-files `("~/Documents/org/work.org"
                           "~/Documents/org/personal.org")))

(after! org
  (setq org-capture-templates
      `(("w" "Work" entry (file "~/Documents/org/work.org")
        "* [ ] %?\n" :prepend t)
        ("p" "Personal" entry (file "~/Documents/org/personal.org")
         "* [ ] %?\n" :prepend t)
        ("n" "Notes" entry (file "~/Documents/org/notes.org")
         "* %?\n"))
      ))

(use-package! websocket
    :after org-roam)


;; roam-org
;;
(use-package! org-roam
  :init
  (setq org-roam-v2-ack t)
  :config
  (org-roam-setup)
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("r" "bibliography reference" plain "%?"
           :if-new
           (file+head "references/${citekey}.org" "#+title: ${title}\n")
           :unnarrowed t)))
  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain
           (function org-roam-capture--get-point)
           "%?"
           :file-name "${slug}"
           :head "+roam_key: ${ref}
#+roam_tags: website
#+title: ${title}

- source :: ${ref}"
           :unnarrowed t)))
  (set-company-backend! 'org-mode '(company-capf)))

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
	  org-roam-ui-follow t
	  org-roam-ui-update-on-save t
	  org-roam-ui-open-on-start t))

(use-package! org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq orb-preformat-keywords '("citekey" "author" "date"))
  (setq orb-templates
        `(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "lit/${slug}"
           :head ,(concat
                   "#+title: ${title}\n"
                   "#+roam_key: cite:${citekey}\n\n"
                   "* ${title}\n"
                   "  :PROPERTIES:\n"
                   "  :AUTHOR: ${author}\n"
                   "  :NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")\n"
                   "  :NOTER_PAGE: \n"
                   "  :END:\n")
           :unnarrowed t))))

(use-package! bibtex-completion
  :config
  (setq bibtex-completion-notes-path "~/Documents/org/"
        bibtex-completion-bibliography "~/Documents/org/zotero.bib"
        bibtex-completion-library-path "~/Documents/pdfs"
        bibtex-completion-pdf-field "file"
        bibtex-completion-notes-template-multiple-files
         (concat
          "#+title: ${title}\n"
          "#+roam_key: cite:${=key=}\n"
          "* TODO Notes\n"
          ":PROPERTIES:\n"
          ":Custom_ID: ${=key=}\n"
          ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
          ":AUTHOR: ${author-abbrev}\n"
          ":JOURNAL: ${journaltitle}\n"
          ":DATE: ${date}\n"
          ":YEAR: ${year}\n"
          ":DOI: ${doi}\n"
          ":URL: ${url}\n"
          ":END:\n\n"
          )))

;; org-ref
;;
(use-package! org-ref
  :after org
  :config
  (setq org-ref-pdf-directory "~/Documents/pdfs")
  (setq org-ref-notes-function 'orb-edit-notes)
  (setq org-ref-default-bibliography `,(list (concat org-directory "zotero.bib")))
  (setq org-ref-formatted-citation-formats
  '(("text"
           ("article" . "${author}, ${title}, ${journal}, ${volume}(${number}), ${pages} (${year}). ${doi}")
           ("inproceedings" . "${author}, ${title}, In ${editor}, ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("book" . "${author}, ${title} (${year}), ${address}: ${publisher}.") ("phdthesis"
                                                                                  . "${author}, ${title} (Doctoral dissertation) (${year}). ${school}, ${address}.")
           ("inbook" . "${author}, ${title}, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("incollection" . "${author}, ${title}, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("proceedings" . "${editor} (Eds.), ${booktitle} (${year}). ${address}: ${publisher}.")
           ("unpublished" . "${author}, ${title} (${year}). Unpublished manuscript.") (nil
                                                                                       . "${author}, ${title} (${year})."))
          ("org"
           ("article" . "${author}, /${title}/, ${journal}, *${volume}(${number})*, ${pages} (${year}). ${doi}")
           ("inproceedings" . "${author}, /${title}/, In ${editor}, ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("book" . "${author}, /${title}/ (${year}), ${address}: ${publisher}.") ("phdthesis"
                                                                                    . "${author}, /${title}/ (Doctoral dissertation) (${year}). ${school}, ${address}.")
           ("inbook" . "${author}, /${title}/, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("incollection" . "${author}, /${title}/, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("proceedings" . "${editor} (Eds.), _${booktitle}_ (${year}). ${address}: ${publisher}.")
           ("unpublished" . "${author}, /${title}/ (${year}). Unpublished manuscript.")
           (nil . "${author}, /${title}/ (${year})."))

          ("md"
           ("article" . "${author}, *${title}*, ${journal}, *${volume}(${number})*, ${pages} (${year}). ${doi}")
           ("inproceedings" . "${author}, *${title}*, In ${editor}, ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("book" . "${author}, *${title}* (${date}), ${location}: ${publisher}.")
           ("phdthesis" . "${author}, *${title}* (Doctoral dissertation) (${year}). ${school}, ${address}.")
           ("inbook" . "${author}, *${title}*, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("incollection" . "${author}, *${title}*, In ${editor} (Eds.), ${booktitle} (pp. ${pages}) (${year}). ${address}: ${publisher}.")
           ("proceedings" . "${editor} (Eds.), _${booktitle}_ (${year}). ${address}: ${publisher}.")
           ("unpublished" . "${author}, *${title}* (${year}). Unpublished manuscript.")
           (nil . "${author}, *${title}* (${year}).")))))

;; org-latex
;;
(after! org-latex
  (setq org-latex-create-formula-image-program 'dvipng
        org-latex-listings 'minted))
(setq org-latex-pdf-process '("latexmk -pdf -pdflatex='xelatex -interaction=nonstopmode -shell-escape' %f")
      org-latex-compiler "xelatex"
      org-latex-caption-above nil)
(add-to-list 'org-latex-packages-alist '("" "fontspec" t))
(add-to-list 'org-latex-packages-alist '("" "listings" t))
(add-to-list 'org-latex-packages-alist '("" "xcolor" t))
(add-to-list 'org-latex-packages-alist '("" "blindtext" t))
(setq bibtex-dialect 'biblatex)

(add-hook! 'org-mode-hook 'org-fragtog-mode)

;; org-journal
;;
(setq org-journal-dir "~/Documents/org/journal"
      org-journal-date-prefix "#+title: "
      org-journal-time-prefix "* "
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-date-format "%a, %Y-%m-%d")

;; org-download
;;
(use-package! org-download
  :commands
  org-download-clipboard
  org-download-dnd
  org-download-dnd-base64
  org-download-yank
  :init
  (map! :map org-mode-map
        "M-s Y" #'org-download-clipboard
        "M-s y" #'org-download-yank)
  :config
  (setq org-download-image-dir "~/Pictures/org"))

;; projectile
;;
(setq projectile-project-search-path '("~/Code/" "~/Documents/"))

;; python
(setq python-indent-guess-indent-offset nil
      python-indent-offset 4)

;; gif screencasts
;;
(use-package! gif-screencast
  :bind
  ("<f12>" . gif-screencast-start-or-stop))

;; syncthing
;;
(use-package! emacs-conflict)

;; treemacs-persp
;; https://github.com/hlissner/doom-emacs/issues/1348#issuecomment-608083367
;;
(use-package! treemacs-persp
  :when (featurep! :ui workspaces)
  :after (treemacs persp-mode)
  :config
  (treemacs-set-scope-type 'Perspectives))

(after! treemacs
  (defun +treemacs--init ()
    (require 'treemacs)
    (let ((origin-buffer (current-buffer)))
      (cl-letf (((symbol-function 'treemacs-workspace->is-empty?)
                 (symbol-function 'ignore)))
        (treemacs--init))
      (unless (bound-and-true-p persp-mode)
        (dolist (project (treemacs-workspace->projects (treemacs-current-workspace)))
          (treemacs-do-remove-project-from-workspace project)))
      (with-current-buffer origin-buffer
        (let ((project-root (or (doom-project-root) default-directory)))
          (treemacs-do-add-project-to-workspace
           (treemacs--canonical-path project-root)
           (doom-project-name project-root)))
        (setq treemacs--ready-to-follow t)
        (when (or treemacs-follow-after-init treemacs-follow-mode)
          (treemacs--follow))))))

(defun my-indent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(global-set-key ">" 'my-indent-region)
(global-set-key "<" 'my-unindent-region)

(add-to-list 'load-path (concat (getenv "GOPATH")  "/pkg/mod/golang.org/x/lint@v0.0.0-20210508222113-6edffad5e616/misc/emacs/"))
(require 'golint)
;; (use-package composite
;;   :defer t
;;   :init
;;   (defvar composition-ligature-table (make-char-table nil))
;;   :hook
;;   (((prog-mode conf-mode nxml-mode markdown-mode help-mode)
;;     . (lambda () (setq-local composition-function-table composition-ligature-table))))
;;   :config
;;   ;; support ligatures, some toned down to prevent hang
;;   (when (version<= "27.0" emacs-version)
;;     (let ((alist
;;            '((33 . ".\\(?:\\(==\\|[!=]\\)[!=]?\\)")
;;              (35 . ".\\(?:\\(###?\\|_(\\|[(:=?[_{]\\)[#(:=?[_{]?\\)")
;;              (36 . ".\\(?:\\(>\\)>?\\)")
;;              (37 . ".\\(?:\\(%\\)%?\\)")
;;              (38 . ".\\(?:\\(&\\)&?\\)")
;;              (42 . ".\\(?:\\(\\*\\*\\|[*>]\\)[*>]?\\)")
;;              ;; (42 . ".\\(?:\\(\\*\\*\\|[*/>]\\).?\\)")
;;              (43 . ".\\(?:\\([>]\\)>?\\)")
;;              ;; (43 . ".\\(?:\\(\\+\\+\\|[+>]\\).?\\)")
;;              (45 . ".\\(?:\\(-[->]\\|<<\\|>>\\|[-<>|~]\\)[-<>|~]?\\)")
;;              ;; (46 . ".\\(?:\\(\\.[.<]\\|[-.=]\\)[-.<=]?\\)")
;;              (46 . ".\\(?:\\(\\.<\\|[-=]\\)[-<=]?\\)")
;;              (47 . ".\\(?:\\(//\\|==\\|[=>]\\)[/=>]?\\)")
;;              ;; (47 . ".\\(?:\\(//\\|==\\|[*/=>]\\).?\\)")
;;              (48 . ".\\(?:\\(x[a-fA-F0-9]\\).?\\)")
;;              (58 . ".\\(?:\\(::\\|[:<=>]\\)[:<=>]?\\)")
;;              (59 . ".\\(?:\\(;\\);?\\)")
;;              (60 . ".\\(?:\\(!--\\|\\$>\\|\\*>\\|\\+>\\|-[-<>|]\\|/>\\|<[-<=]\\|=[<>|]\\|==>?\\||>\\||||?\\|~[>~]\\|[$*+/:<=>|~-]\\)[$*+/:<=>|~-]?\\)")
;;              (61 . ".\\(?:\\(!=\\|/=\\|:=\\|<<\\|=[=>]\\|>>\\|[=>]\\)[=<>]?\\)")
;;              (62 . ".\\(?:\\(->\\|=>\\|>[-=>]\\|[-:=>]\\)[-:=>]?\\)")
;;              (63 . ".\\(?:\\([.:=?]\\)[.:=?]?\\)")
;;              (91 . ".\\(?:\\(|\\)[]|]?\\)")
;;              ;; (92 . ".\\(?:\\([\\n]\\)[\\]?\\)")
;;              (94 . ".\\(?:\\(=\\)=?\\)")
;;              (95 . ".\\(?:\\(|_\\|[_]\\)_?\\)")
;;              (119 . ".\\(?:\\(ww\\)w?\\)")
;;              (123 . ".\\(?:\\(|\\)[|}]?\\)")
;;              (124 . ".\\(?:\\(->\\|=>\\||[-=>]\\||||*>\\|[]=>|}-]\\).?\\)")
;;              (126 . ".\\(?:\\(~>\\|[-=>@~]\\)[-=>@~]?\\)"))))
;;       (dolist (char-regexp alist)
;;         (set-char-table-range composition-ligature-table (car char-regexp)
;;                               `([,(cdr char-regexp) 0 font-shape-gstring]))))
;;     (set-char-table-parent composition-ligature-table composition-function-table))
;;   )
