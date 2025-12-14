
# README — simulate_wall_temp (Package « Mur Intelligent »)

## Description
`simulate_wall_temp` est la fonction coeur de ton package : elle simule l'évolution temporelle de la température intérieure en résolvant (ou, dans la version actuelle, approchant) l'équation de la chaleur pour une paroi multi-couches. La version fournie contient une implémentation simplifiée et un placeholder que tu peux remplacer par une résolution par différences finies (FDM).

> Le code source de la fonction utilisée pour rédiger ce README est inclus dans ton dépôt. fileciteturn0file0

---

## Usage rapide

```r
# Chargement (supposant que ton package est installé ou que le fichier R est sourcé)
# source("R/simulate_wall_temp.R") # si tu gardes la fonction dans ce fichier

concrete_data <- data.frame(
  material = "Concrete",
  thickness_m = 0.20,
  conductivity_w_mk = 1.0,
  density_kg_m3 = 2400,
  specific_heat_j_kgk = 880
)

results <- simulate_wall_temp(
  materials = concrete_data,
  initial_temp_in = 25,        # température intérieure initiale (°C)
  external_temp = 35,         # température extérieure (°C) ou vecteur temporel
  total_time = 24,            # durée totale de simulation (heures)
  dt = 0.01,                  # pas de temps (heures)
  dx = 0.01                   # pas d'espace (m) — utilisé si tu implémentes FDM
)

plot(results$Time, results$InternalTemp, type = "l",
     xlab = "Temps (heures)", ylab = "Température intérieure (°C)",
     main = "Évolution de la température intérieure")
```

---

## Paramètres (détaillés)

- **materials** : data.frame décrivant chaque couche du mur. Colonnes attendues :
  - `material` : nom du matériau (chaîne)
  - `thickness_m` : épaisseur (m)
  - `conductivity_w_mk` : conductivité thermique (W·m⁻¹·K⁻¹)
  - `density_kg_m3` : masse volumique (kg·m⁻³)
  - `specific_heat_j_kgk` : capacité thermique massique (J·kg⁻¹·K⁻¹)

- **initial_temp_in** : température intérieure initiale (°C)
- **external_temp** : température extérieure — peut être un scalaire (constante) ou un vecteur/serie temporelle (même longueur que `seq(0, total_time, by = dt)`)
- **total_time** : temps total de simulation (heures)
- **dt** : pas de temps (heures)
- **dx** : pas d'espace (m) — utile si tu implémentes une discrétisation spatiale réelle

---

## Format de sortie

La fonction renvoie un `data.frame` contenant au minimum :
- `Time` : le temps (heures)
- `InternalTemp` : la température intérieure simulée (°C)

Tu peux enrichir ce résultat en ajoutant :
- profils de température spatiaux à chaque pas de temps (si FDM implémenté)
- flux thermiques, énergie stockée, etc.

---

## Limites actuelles et améliorations proposées

La version actuelle contient **une approximation simple** (la température intérieure converge lentement vers la température extérieure selon un taux dépendant de la conductivité/épaisseur). Pour la rendre physiquement rigoureuse, je recommande :
1. **Implémenter une discrétisation spatiale et temporelle par différences finies (FDM)** pour résoudre ​
   \( \partial_t u = \alpha \partial_{xx} u \) avec appropriation de \(\alpha = \frac{k}{\rho c}\).  
2. **Gérer des conditions aux limites variables** (température extérieure dependante du temps, convection en surface, échanges radiatifs).  
3. **Autres extensions utiles** :
   - modèles multi-physiques (humidité + chaleur)
   - intégration d'un contrôle « intelligent » (ex : matériaux à changement de phase, actionneurs)  
   - visualisations spatiales (cartes 2D) ou animations temporelles

---

## Conseils d'implémentation FDM (rapide)

- Détermine pour chaque couche la diffusivité thermique : \(\alpha = k / (\rho c)\).
- Construis un maillage spatial `x` en tenant compte des différentes épaisseurs de couche (affecter `dx` par couche ou utiliser masque de densité).
- Utilise un schéma implicite (ex : Crank–Nicolson) pour assurer la stabilité à des pas de temps raisonnables.
- Vérifie la condition de stabilité pour les schémas explicites :
  \( dt \le \frac{dx^2}{2 \alpha_{max}} \).

---

## Tests & Validation

- Compare la solution numérique à une solution analytique pour une plaque homogène et conditions aux limites simples (par exemple, condition de Dirichlet constantes).
- Vérifie la convergence en raffinement `dx` / `dt`.
- Teste différents matériaux (briques, béton, isolant) et vérifie la cohérence physique.

---

## Exemple avancé (température extérieure variable)

```r
# Température extérieure qui varie toute la journée (ex: sinusoïde)
t_seq <- seq(0, 24, by = 0.01)
ext_temp_series <- 30 + 5 * sin(2 * pi * t_seq / 24) # oscillation diurne ±5°C

res <- simulate_wall_temp(
  materials = concrete_data,
  initial_temp_in = 25,
  external_temp = ext_temp_series,
  total_time = 24,
  dt = 0.01,
  dx = 0.01
)
```

---

## Contribution & organisation du dépôt

- Place `simulate_wall_temp.R` dans `R/` et documente la fonction avec roxygen2 (comme déjà commencé).
- Ajoute un petit script `inst/examples/` montrant plusieurs scénarios pour Douala (températures réelles ou modèles diurnes).
- Ajoute des tests unitaires avec `testthat` pour la structure des entrées/sorties.

---

## Auteur / Licence

- Auteur :Noumedem
- Licence : MIT

---


