---
date: 2024/03/19
tags: 
Materia: "[[Calcolatori]]"
---
$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\Fcal}{\mathcal{F}}$
## Operatori base
### AND
$$
A \cdot B
$$

|  A  | B   | OUTPUT |
|:---:| --- | ------ |
|  0  | 0   | 0      |
|  0  | 1   | 0      |
|  1  | 1   | 1      |
### OR
$$
A + B
$$

|  A  | B   | OUTPUT |
| :-: | --- | ------ |
|  0  | 0   | 0      |
|  0  | 1   | 1      |
|  1  | 1   | 1      |

### NOT
$$
\overline{A}
$$

|  A  | OUTPUT |
|:---:| ------ |
|  0  | 1      |
|  1  | 0      |

## Proprietà algebra di boole
1. **Identità**:
$$ A + 0 = A $$
$$ A \cdot 1 = A $$

2. **Annullamento**:
$$ A + A' = 1 $$
$$ A \cdot A' = 0 $$

3. **Complemento**:
$$ A + A = A $$
$$ A \cdot A' = 0 $$

4. **Commutatività**:
$$ A + B = B + A $$
$$ A \cdot B = B \cdot A $$

5. **Associatività**:
$$ A + (B + C) = (A + B) + C $$
$$ A \cdot (B \cdot C) = (A \cdot B) \cdot C $$

6. **Distributività**:
$$ A \cdot (B + C) = (A \cdot B) + (A \cdot C) $$
$$ A + (B \cdot C) = (A + B) \cdot (A + C) $$

7. **Assorbimento**:
$$ A + (A \cdot B) = A $$
$$ A \cdot (A + B) = A $$

8. **De Morgan**:
$$ (A + B)' = A' \cdot B' $$
$$ (A \cdot B)' = A' + B' $$
