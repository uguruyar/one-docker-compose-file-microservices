-- Eğer tablo yoksa oluştur
CREATE TABLE IF NOT EXISTS pokemon (
    num INT,
    name TEXT,
    type1 TEXT,
    type2 TEXT,
    total INT,
    hp INT,
    attack INT,
    defense INT,
    special_attack INT,
    special_defense INT,
    speed INT,
    generation INT,
    legendary BOOLEAN
);

-- Önce tabloyu temizle (opsiyonel, init sırasında tekrar çalıştırırsan sorun çıkmasın)
TRUNCATE TABLE pokemon;

-- CSV verisini tabloya kopyala
COPY pokemon(
    num, name, type1, type2, total, hp, attack, defense, 
    special_attack, special_defense, speed, generation, legendary
)
FROM '/docker-entrypoint-initdb.d/pokemon.csv'
DELIMITER ','
CSV HEADER;