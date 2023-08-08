;; Elimina la barra de menú, la barra de herramientas y la barra de desplazamiento.

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Iniciar Emacs de forma maximizada
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Cargar el archivo de configuración de emacs con C-c l
(global-set-key (kbd "C-c l")
		'(lambda () (interactive) (find-file user-init-file)))

;; Org Agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; Quitar el mensaje de inicio
(setq inhibit-startup-message t)

;; Nos brinda un aumento en el margen izquierdo de 10 unidades.
(set-fringe-mode 10)

;; Cambiar la fuente de emacs.
(set-face-attribute 'default nil
		    :font "JetBrains Mono"
		    :height 110)

;; Visible-bell es un indicador que nos muestra si estamos en el límite superior o de nuestro buffer

(setq visible-bell t)

;; Agregar número de línea relativo

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Líneas que se parten al llegar al límite derecho del texto:
(global-visual-line-mode t)

;; Creamos la función "no despliegues" por los lulz

(defun no-despliegues()
  (display-line-numbers-mode -1)
)

;; Utilizamos la función para quitar los números de línea en modos que no lo requieren.
(add-hook 'org-mode-hook 'no-despliegues)
(add-hook 'eshell-mode-hook 'no-despliegues)
(add-hook 'markdown-mode-hook 'no-despliegues)

(setq browse-url-browser-function 'browse-url-firefox)

;; Indentación en org-mode
(setq org-startup-indented t)

;; Agregar MELPA, org y ELPA. Y activar use-package

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Instalación de los temas modus y configuración de Modus-Vivendi

(use-package modus-themes)
(load-theme 'modus-vivendi-tinted t)

;; Instalando markdown-mode
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode))

;; Instalando olivetti para modo sin distracciones.
(use-package olivetti)

;; Instalando auctex para la edición de archivos Tex, LaTeX, etc.

(use-package tex
  :ensure auctex)

;; Texto de relleno lorem-ipsum
(use-package lorem-ipsum)

;; Emms
(use-package emms
  :init
  (add-hook 'emms-player-started-hook 'emms-show)
  (setq emms-show-format "Playing: %s")
  :config
  (emms-standard)
  (emms-default-players))

;; Instalando emmet-mode para la creación de html y css

(use-package emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

;; Magit. The Killer app :3
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package toc-org)
(if (require 'toc-org nil t)
    (progn
      (add-hook 'org-mode-hook 'toc-org-mode))
      ;; enable in markdown, too
      ;;(add-hook 'markdown-mode-hook 'toc-org-mode)
      ;;(define-key markdown-mode-map (kbd "\C-c\C-o") 'toc-org-markdown-follow-thing-at-point))
  (warn "toc-org not found"))

;; doom-modeline es la barrita de Doom Emacs. Me gusta como se ve.
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Esta línea le indica a emacs que se usará la fuente Noto Color Emoji para desplegar los emojis
(set-fontset-font t 'symbol (font-spec :family "Noto Color Emoji") nil 'prepend)

;; Instalando el paquete emojify para la inserción de emojis :3
(use-package emojify
  :config
  (when (member "Noto Color Emoji" (font-family-list))
    (set-fontset-font
     t 'symbol (font-spec :family "Noto Color Emoji") nil 'prepend))
  (setq emojify-display-style 'unicode)
  (setq emojify-emoji-styles '(unicode))
  (bind-key* (kbd "C-c .") #'emojify-insert-emoji)) ; override binding in any mode

;; Agregar swiper
(use-package counsel
  :ensure t
)
(use-package swiper
  :ensure try
  :config
  (progn
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  ))

;; Recargar emacs.
(defun recargar()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

;; Iniciar emacsclient -c en una ventana maximizada:
(add-to-list 'default-frame-alist '(fullscreen . maximized)) 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary "castellano8")
 '(org-agenda-files '("~/agenda.org"))
 '(package-selected-packages
   '(try emojify doom-modeline toc-org magit emmet-mode emms lorem-ipsum auctex olivetti markdown-mode modus-themes use-package smex ivy-hydra counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
