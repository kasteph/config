;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Steph Samson"
      user-mail-address "hello@stephsamson.com")

(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 15)
      doom-theme 'doom-nord-light)

(setq org-directory "~/Documents/org"
      org-log-done 'time
      org-roam-directory "~/Documents/org/roam")

(setq display-line-numbers-type t)

(setq projectile-project-search-path '("~/Code/" "~/Documents/"))

(setq fancy-splash-image "~/.doom.d/emacs.png")

;; Python configuration
(use-package! poetry)

(use-package! elpy
  :init
  (elpy-enable))
