;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Steph Samson"
      user-mail-address "hello@stephsamson.com"
      display-line-numbers-type t
      doom-font (font-spec :family "JetBrains Mono" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 15)
      doom-theme 'doom-nord-light
      fancy-splash-image "~/.doom.d/emacs.png"
      fill-column 79)

;; org and family
;;
(setq org-directory "~/Documents/org/"
      org-log-done 'time
      org-roam-directory "~/Documents/org/roam")

(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain
           (function org-roam--capture-get-point)
           "%?"
           :file-name "${slug}"
           :head "#+title: ${title}\n
+STARTUP:latexpreview"
           :immediate-finish t
           :unnarrowed t)
          ("p" "private" plain
           (function org-roam-capture--get-point)
           "%?"
           :file-name "private/${slug}"
           :head "#+title: ${title}\n"
           :immediate-finish t
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

(use-package! org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :load-path "~/Documents/org/biblio.bib"
  :config
  (setq orb-preformat-keywords '("citekey" "author" "date"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "lit/${slug}"
           :head ,(concat
                   "#+title: ${title}\n"
                   "#+roam_key: cite:${citekey}\n\n"
                   "* ${title}\n"
                   "  :PROPERTIES:\n"
                   "  :AUTHOR: ${author}\n"
                   "  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
                   "  :NOTER_PAGE: \n"
                   "  :END:\n")
           :unnarrowed t))))

(use-package! bibtex-completion
  :config
  (setq bibtex-completion-notes-path "~/Documents/org/"
        bibtex-completion-bibliography "~/Documents/org/biblio.bib"
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

(use-package! org-roam-server)

(use-package! org-ref
  :after org
  :config
  (setq org-ref-pdf-directory "~/Documents/pdfs")
  (setq org-ref-default-bibliography `,(list (concat org-directory "biblio.bib")))
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

(setq org-latex-create-formula-image-program 'dvipng)

(add-hook! 'org-mode-hook 'org-fragtog-mode)

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

;; python configuration
;;
(use-package! poetry)

(use-package! elpy
  :init
  (elpy-enable))
