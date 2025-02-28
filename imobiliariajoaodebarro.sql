-- Criar o banco de dados
CREATE DATABASE ImobiliariaJoaoDeBarro;
USE ImobiliariaJoaoDeBarro;

-- Tabela Síndico
CREATE TABLE Sindico (
    Matricula VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255),
    Telefone VARCHAR(20)
);

-- Tabela Condomínio
CREATE TABLE Condominio (
    Codigo INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255),
    Matricula_Sindico VARCHAR(20) UNIQUE,
    FOREIGN KEY (Matricula_Sindico) REFERENCES Sindico(Matricula)
);

-- Tabela Apartamento
CREATE TABLE Apartamento (
    Codigo_Condominio INT,
    Numero INT,
    Tipo ENUM('Padrão', 'Cobertura') NOT NULL,
    PRIMARY KEY (Codigo_Condominio, Numero),
    FOREIGN KEY (Codigo_Condominio) REFERENCES Condominio(Codigo)
);

-- Tabela Garagem (1:1 com Apartamento)
CREATE TABLE Garagem (
    Codigo_Condominio INT,
    Numero_Apartamento INT,
    Numero_Garagem INT UNIQUE NOT NULL,
    Tipo ENUM('Padrão', 'Coberta') NOT NULL,
    PRIMARY KEY (Codigo_Condominio, Numero_Apartamento),
    FOREIGN KEY (Codigo_Condominio, Numero_Apartamento) 
        REFERENCES Apartamento(Codigo_Condominio, Numero)
);

-- Tabela Proprietário
CREATE TABLE Proprietario (
    RG VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(255) UNIQUE
);

-- Tabela de relacionamento Proprietário-Apartamento (N:M)
CREATE TABLE Proprietario_Apartamento (
    RG_Proprietario VARCHAR(20),
    Codigo_Condominio INT,
    Numero_Apartamento INT,
    PRIMARY KEY (RG_Proprietario, Codigo_Condominio, Numero_Apartamento),
    FOREIGN KEY (RG_Proprietario) REFERENCES Proprietario(RG),
    FOREIGN KEY (Codigo_Condominio, Numero_Apartamento) 
        REFERENCES Apartamento(Codigo_Condominio, Numero)
);
