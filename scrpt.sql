CREATE DATABASE CentreMedical;
USE CentreMedical;


-- exercise 1 

CREATE TABLE Utilisateurs (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    type_utilisateur ENUM('patient', 'medecin') NOT NULL
);

CREATE TABLE Rendezvous (
    id_rdv INT AUTO_INCREMENT PRIMARY KEY,
    id_patient INT NOT NULL,
    id_medecin INT NOT NULL,
    date_rdv DATETIME NOT NULL,
    status ENUM('confirmé', 'non confirmé') NOT NULL,
    FOREIGN KEY (id_patient) REFERENCES Utilisateurs(id_utilisateur),
    FOREIGN KEY (id_medecin) REFERENCES Utilisateurs(id_utilisateur)
);

CREATE TABLE Factures (
    id_facture INT AUTO_INCREMENT PRIMARY KEY,
    id_rdv INT NOT NULL,
    montant DECIMAL(10, 2) NOT NULL,
    date_facture DATETIME NOT NULL,
    FOREIGN KEY (id_rdv) REFERENCES Rendezvous(id_rdv)
);


-- exercise 2

INSERT INTO Utilisateurs (nom, prenom, type_utilisateur) VALUES 
('tarik', 'sanimi', 'patient'),
('monsef', 'marsoul', 'patient'),
('yasser', 'chanaa', 'medecin'),
('hicham', 'oubaha', 'medecin');



INSERT INTO Rendezvous (id_patient, id_medecin, date_rdv, status) VALUES 
(1, 3, '2024-12-20', 'confirmé'),
(2, 3, '2024-12-21', 'non confirmé'),
(1, 4, '2024-12-22', 'confirmé'),
(2, 4, '2024-12-23', 'confirmé'),
(1, 3, '2024-12-24', 'non confirmé');


INSERT INTO Factures (id_rdv, montant, date_facture) VALUES 
(1, 50.00, '2024-12-20'),
(3, 70.00, '2024-12-22'),
(4, 80.00, '2024-12-23');



-- exercise 3 

SELECT * FROM Rendezvous WHERE id_patient = 1;


SELECT * FROM Rendezvous WHERE status = 'confirmé' OR status = 'non confirmé';



SELECT 
    rdv.id_rdv, 
    rdv.date_rdv, 
    rdv.status, 
    patient.nom AS patient_nom, 
    patient.prenom AS patient_prenom, 
    medecin.nom AS medecin_nom, 
    medecin.prenom AS medecin_prenom
FROM 
    Rendezvous rdv
JOIN 
    Utilisateurs patient ON rdv.id_patient = patient.id_utilisateur
JOIN 
    Utilisateurs medecin ON rdv.id_medecin = medecin.id_utilisateur;




    -- exercise 4 

    UPDATE Rendezvous SET status = 'confirmé' WHERE id_rdv = 2;


  -- exercise  5 

DELETE FROM Rendezvous WHERE id_rdv = 2;


DELETE FROM Utilisateurs WHERE id_utilisateur = 1;













































-- exercise 6 

-- Calcul du nombre total de rendez-vous par patient 

SELECT id_patient, COUNT(*) AS total_rendezvous 
FROM Rendezvous 
GROUP BY id_patient;

-- Somme des montants des factures par patient 

SELECT 
    rdv.id_patient, 
    SUM(fact.montant) AS total_montant
FROM 
    Factures fact
JOIN 
    Rendezvous rdv ON fact.id_rdv = rdv.id_rdv
GROUP BY 
    rdv.id_patient;


-- Moyenne des montants des factures pour tous les rendez-vous confirmés

SELECT AVG(fact.montant) AS moyenne_montant
FROM 
    Factures fact
JOIN 
    Rendezvous rdv ON fact.id_rdv = rdv.id_rdv
WHERE 
    rdv.status = 'confirmé';


-- Rendez-vous les plus récents et les plus anciens

SELECT 
    MIN(date_rdv) AS rendezvous_plus_ancien, 
    MAX(date_rdv) AS rendezvous_plus_recent
FROM 
    Rendezvous;


-- Top des médecins avec le plus de rendez-vous confirmés

SELECT 
    rdv.id_medecin, 
    med.nom, 
    med.prenom, 
    COUNT(*) AS total_confirmés
FROM 
    Rendezvous rdv
JOIN 
    Utilisateurs med ON rdv.id_medecin = med.id_utilisateur
WHERE 
    rdv.status = 'confirmé'
GROUP BY 
    rdv.id_medecin
ORDER BY 
    total_confirmés DESC;





