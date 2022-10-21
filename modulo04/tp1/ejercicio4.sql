-- TP1 - Base de Datos
-- Alumno: Markovich Juan Andrés
-- Ejercicio 4 - Scripts SQL


-- Scripts SQL EJERCICIO 1 - Academia

DROP DATABASE IF EXISTS `academia`;

CREATE DATABASE IF NOT EXISTS `academia`;

CREATE TABLE IF NOT EXISTS `academia`.`alumno` (
  `matricula_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(15) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`matricula_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `academia`.`profesor` (
  `profesor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `especialidad` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`profesor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `academia`.`curso` (
  `curso_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`curso_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `academia`.`curso_con_profesor` (
  `matricula_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `curso_curso_id` INT UNSIGNED NOT NULL,
  `profesor_profesor_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`matricula_id`),
  INDEX `fk_curso_has_profesor_profesor1_idx` (`profesor_profesor_id` ASC) VISIBLE,
  INDEX `fk_curso_has_profesor_curso_idx` (`curso_curso_id` ASC) VISIBLE,
  CONSTRAINT `fk_curso_has_profesor_curso`
    FOREIGN KEY (`curso_curso_id`)
    REFERENCES `academia`.`curso` (`curso_id`),
  CONSTRAINT `fk_curso_has_profesor_profesor1`
    FOREIGN KEY (`profesor_profesor_id`)
    REFERENCES `academia`.`profesor` (`profesor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `academia`.`alumno_con_curso` (
  `alumno_con_curso_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `alumno_matricula_id` INT UNSIGNED NOT NULL,
  `curso_curso_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`alumno_con_curso_id`),
  INDEX `fk_alumno_has_curso_curso1_idx` (`curso_curso_id` ASC) VISIBLE,
  INDEX `fk_alumno_has_curso_alumno1_idx` (`alumno_matricula_id` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_has_curso_alumno1`
    FOREIGN KEY (`alumno_matricula_id`)
    REFERENCES `academia`.`alumno` (`matricula_id`),
  CONSTRAINT `fk_alumno_has_curso_curso1`
    FOREIGN KEY (`curso_curso_id`)
    REFERENCES `academia`.`curso` (`curso_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO `academia`.`alumno` (`nombre`, `dni`, `fecha_nacimiento`, `email`) VALUES ('Juan Jose', '25635478', '1980-12-03', 'elmail@gmail.com');
INSERT INTO `academia`.`alumno` (`nombre`, `dni`, `fecha_nacimiento`, `email`) VALUES ('Pedro Norberto', '45254896', '1995-05-30', 'suemail@gmail.com');
INSERT INTO `academia`.`alumno` (`nombre`, `dni`, `fecha_nacimiento`, `email`) VALUES ('Lorena Barrera', '7958652', '1965-12-25', 'sineamail@gmail.com');

INSERT INTO `academia`.`curso` (`nombre`) VALUES ('Carpintería');
INSERT INTO `academia`.`curso` (`nombre`) VALUES ('Pintura Sobre Tela');
INSERT INTO `academia`.`curso` (`nombre`) VALUES ('Cuadros en acuarelas');

INSERT INTO `academia`.`profesor` (`nombre`, `especialidad`, `email`) VALUES ('Manuela Romero', 'Artista Plástico', 'manuela@laartista.com');
INSERT INTO `academia`.`profesor` (`nombre`, `especialidad`, `email`) VALUES ('Armando Esteban Quito', 'Carpintero ', 'tabu@rete.com');
INSERT INTO `academia`.`profesor` (`nombre`, `especialidad`, `email`) VALUES ('Jose Ramón Consuel', 'Maestro de Labores', 'elartista@sobretela.com');

INSERT INTO `academia`.`curso_con_profesor` (`curso_curso_id`, `profesor_profesor_id`) VALUES ('1', '2');
INSERT INTO `academia`.`curso_con_profesor` (`curso_curso_id`, `profesor_profesor_id`) VALUES ('2', '3');
INSERT INTO `academia`.`curso_con_profesor` (`curso_curso_id`, `profesor_profesor_id`) VALUES ('3', '1');

INSERT INTO `academia`.`alumno_con_curso` (`alumno_matricula_id`, `curso_curso_id`) VALUES ('1', '1');
INSERT INTO `academia`.`alumno_con_curso` (`alumno_matricula_id`, `curso_curso_id`) VALUES ('2', '2');
INSERT INTO `academia`.`alumno_con_curso` (`alumno_matricula_id`, `curso_curso_id`) VALUES ('3', '3');



-- Scripts SQL EJERCICIO 2 - Paises

DROP DATABASE IF EXISTS `paises`;

CREATE DATABASE IF NOT EXISTS `paises`;

CREATE TABLE IF NOT EXISTS `paises`.`pais` (
  `pais_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pais_id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `paises`.`provincia` (
  `provincia_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `pais_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`provincia_id`, `pais_id`),
  INDEX `fk_provincia_pais_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `fk_provincia_pais`
    FOREIGN KEY (`pais_id`)
    REFERENCES `paises`.`pais` (`pais_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `paises`.`localidad` (
  `localidad_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`localidad_id`, `provincia_id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `paises`.`provincia` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `paises`.`empleado` (
  `empleado_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dni` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `localidad_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`empleado_id`, `localidad_id`),
  INDEX `fk_empleado_localidad1_idx` (`localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_localidad1`
    FOREIGN KEY (`localidad_id`)
    REFERENCES `paises`.`localidad` (`localidad_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO `paises`.`pais` (`nombre`) VALUES ('Argentina');
INSERT INTO `paises`.`pais` (`nombre`) VALUES ('Brasil');
INSERT INTO `paises`.`pais` (`nombre`) VALUES ('Paraguay');

INSERT INTO `paises`.`provincia` (`nombre`, `pais_id`) VALUES ('Misiones', '1');
INSERT INTO `paises`.`provincia` (`nombre`, `pais_id`) VALUES ('Corrientes', '1');
INSERT INTO `paises`.`provincia` (`nombre`, `pais_id`) VALUES ('Entre Rios', '1');

INSERT INTO `paises`.`localidad` (`localidad`, `provincia_id`) VALUES ('Posadas', '1');
INSERT INTO `paises`.`localidad` (`localidad`, `provincia_id`) VALUES ('Oberá', '1');
INSERT INTO `paises`.`localidad` (`localidad`, `provincia_id`) VALUES ('Eldorado', '1');

INSERT INTO `paises`.`empleado` (`dni`, `nombre`, `telefono`, `email`, `fecha_alta`, `localidad_id`) VALUES ('29445125', 'Juan Andres', '3764258500', 'juan@gmail.com', '2022-10-21', '1');
INSERT INTO `paises`.`empleado` (`dni`, `nombre`, `telefono`, `email`, `fecha_alta`, `localidad_id`) VALUES ('29521444', 'Ramon Alberto', '37552547896', 'ramon@gmail.com', '2022-10-21', '2');
INSERT INTO `paises`.`empleado` (`dni`, `nombre`, `telefono`, `email`, `fecha_alta`, `localidad_id`) VALUES ('41258321', 'Axel Kuch', '3758256314', 'axel@kuch.com', '2022-10-21', '3');



-- Scripts SQL EJERCICIO 3 - Alquiler de alquiler_coches

DROP DATABASE IF EXISTS `alquiler_coches`;

CREATE DATABASE IF NOT EXISTS `alquiler_coches`;

CREATE TABLE IF NOT EXISTS `alquiler_coches`.`coche` (
  `coche_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(15) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `precio_hora` INT UNSIGNED NOT NULL,
  `gasolina_disponible` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`coche_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `alquiler_coches`.`cliente` (
  `cliente_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(12) NOT NULL,
  `direccion` VARCHAR(60) NOT NULL,
  `telefono` VARCHAR(17) NOT NULL,
  `aval` INT NULL DEFAULT NULL,
  PRIMARY KEY (`cliente_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `alquiler_coches`.`reserva` (
  `reserva_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_reserva` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_finalizacion` DATE NULL DEFAULT NULL,
  `precio` INT NULL DEFAULT NULL,
  `coche_coche_id` INT UNSIGNED NOT NULL,
  `cliente_cliente_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`reserva_id`, `coche_coche_id`, `cliente_cliente_id`),
  INDEX `fk_reserva_coche_idx` (`coche_coche_id` ASC) VISIBLE,
  INDEX `fk_reserva_cliente1_idx` (`cliente_cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_coche`
    FOREIGN KEY (`coche_coche_id`)
    REFERENCES `alquiler_coches`.`coche` (`coche_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_cliente1`
    FOREIGN KEY (`cliente_cliente_id`)
    REFERENCES `alquiler_coches`.`cliente` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO `alquiler_coches`.`cliente` (`nombre`, `dni`, `direccion`, `telefono`) VALUES ('Juan Andres', '295142258', 'Posadas', '376425622');
INSERT INTO `alquiler_coches`.`cliente` (`nombre`, `dni`, `direccion`, `telefono`, `aval`) VALUES ('Pedro Roman', '45875256', 'Obera', '37554201256', '1');
INSERT INTO `alquiler_coches`.`cliente` (`nombre`, `dni`, `direccion`, `telefono`, `aval`) VALUES ('Chango Spaciuk', '15236987', 'Eldorado', '3758258412', '2');

INSERT INTO `alquiler_coches`.`coche` (`matricula`, `modelo`, `marca`, `precio_hora`, `gasolina_disponible`) VALUES ('AV125GD', 'Suran', 'VW', '1500', '15');
INSERT INTO `alquiler_coches`.`coche` (`matricula`, `modelo`, `marca`, `precio_hora`, `gasolina_disponible`) VALUES ('ABC175', 'Celta', 'Chevrolet', '950', '45');
INSERT INTO `alquiler_coches`.`coche` (`matricula`, `modelo`, `marca`, `precio_hora`, `gasolina_disponible`) VALUES ('AC458JJ', 'Corolla', 'Toyota', '2300', '25');

INSERT INTO `alquiler_coches`.`reserva` (`fecha_finalizacion`, `precio`, `coche_coche_id`, `cliente_cliente_id`) VALUES ('2022-10-25', '3500', '1', '1');
INSERT INTO `alquiler_coches`.`reserva` (`fecha_finalizacion`, `precio`, `coche_coche_id`, `cliente_cliente_id`) VALUES ('2022-10-28', '2500', '2', '1');
INSERT INTO `alquiler_coches`.`reserva` (`fecha_finalizacion`, `precio`, `coche_coche_id`, `cliente_cliente_id`) VALUES ('2022-11-05', '4500', '3', '2');
