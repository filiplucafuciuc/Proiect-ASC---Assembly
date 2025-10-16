# Tema – Gestionarea unui dispozitiv de stocare într-un sistem de operare minimal

Proiectul presupune că faci parte din echipa de dezvoltare a unui **sistem de operare minimal**, responsabilă de implementarea unei componente esențiale: **modulul de gestiune al dispozitivului de stocare** *(hard-disk sau SSD)*. Acest modul are rolul de a administra modul în care datele sunt **plasate**, **localizate** și **reorganizate** în memoria persistentă, asigurând un acces eficient și controlat la resursele de stocare ale sistemului.

---

## Moduri de funcționare

În cadrul acestei implementări sunt avute în vedere **două moduri de funcționare distincte**:

### • Sistem cu memorie unidimensională (liniară)
O abordare secvențială, în care blocurile de memorie sunt dispuse pe o singură axă logică, iar fișierele sunt stocate în **segmente contigue**.

### • Sistem cu memorie bidimensională (matrice)
O extensie a modelului unidimensional, unde spațiul de stocare este organizat sub formă de **matrice**, permițând o gestionare mai complexă a datelor și **optimizări în alocare și defragmentare**.

---

## Unitatea de măsură și structura memoriei

În ambele cazuri, unitățile de măsură utilizate respectă convențiile standard ale sistemelor de operare:

- **1 MB = 1024 KB**
- **1 KB = 1024 B**

Spațiul de stocare este împărțit în **blocuri de dimensiuni fixe**, care constituie unitatea de bază pentru toate operațiile de gestionare a fișierelor.

---

## Operații fundamentale

Modulul trebuie să poată efectua **operații fundamentale asupra sistemului de fișiere**, precum:

- **adăugarea de fișiere**, prin identificarea primului spațiu disponibil în memorie conform regulilor de alocare;
- **interogarea locației** unui fișier existent, pe baza unui identificator unic (*descriptor*);
- **ștergerea fișierelor** și eliberarea blocurilor de memorie ocupate;
- **defragmentarea dispozitivului**, pentru rearanjarea datelor și consolidarea spațiului liber.

---

## Scopul temei

Prin această temă se urmărește **simularea logicii interne a unui subsistem de stocare**, accentuând conceptele de:

- **alocare contiguă**,
- **fragmentare**,
- **optimizare a spațiului**,

în contextul arhitecturii unui **sistem de operare minimal**.

# Assembly Runner

A seamless assembly runner that simplifies running `.s` and `.asm` x86 assembly files within a Docker container. With this tool, you can quickly execute x86 assembly code without needing to manually handle dependencies or setups.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Examples](#examples)
- [Contributors](#contributors)
- [License](#license)

## Introduction

This project provides a simple interface to run x86 assembly code using Docker containers. By executing a single command, you can compile and run `.s` or `.asm` files. The tool automatically selects the latest assembly file in the current directory if no file is specified.

## Features

- Run `.s` and `.asm` assembly files within a Docker container.
- Auto-select the latest assembly file if no file is specified.
- Easy-to-use command structure for running code.
- Supports running any valid assembly code without manual setup.

## Installation

1. Ensure you have Docker installed on your system.
2. Clone this repository to your local machine:  
   git clone <repository-url>
3. Make sure the `run` script has executable permissions:  
   chmod +x run

## Usage

To run an assembly file, use the following command:
```bash
./run [program_name]
```

The `program_name` argument is optional and specifies which `.s` or `.asm` file to run.  
If `program_name` is not provided, the script will automatically select the latest `.s` or `.asm` file in the current directory.

## Dependencies

Docker is required to run the assembly code in a containerized environment. Ensure Docker is installed and running on your system.

To install all dependencies you can to run
```bash
./run init
```

## Examples

### Running a Specific File

If you have a file named `hello.s` in your directory, you can run it with the following command: 
```bash 
./run hello.s
```

### Running the Latest Assembly File

If you have multiple `.s` and `.asm` files in your directory, you can let the script choose the most recent one by running:
```bash
./run
```


## License

This project is licensed under the MIT License. See the LICENSE file for details.
