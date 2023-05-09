-- EJERCICIOS
/*

1 - Escriba un bloque de codigo PL/pgSQL que reciba una nota como parametro
    y notifique en la consola de mensaje las letras A,B,C,D,E o F segun el valor de la nota
*/
DO $$
DECLARE
  nota FLOAT := 75;
  letra CHAR(1);
BEGIN
  IF nota >= 90 THEN
    letra := 'A';
  ELSIF nota >= 80 THEN
    letra := 'B';
  ELSIF nota >= 70 THEN
    letra := 'C';
  ELSIF nota >= 60 THEN
    letra := 'D';
  ELSIF nota >= 50 THEN
    letra := 'E';
  ELSE
    letra := 'F';
  END IF;
  
  RAISE NOTICE 'La letra correspondiente a la nota % es %', nota, letra;
END $$;


/*
2 - Escriba un bloque de codigo PL/pgSQL que reciba un numero como parametro
    y muestre la tabla de multiplicar de ese numero.
*/

DO $$
DECLARE
  numero INTEGER := 7;
  multiplicador INTEGER := 1;
BEGIN
  WHILE multiplicador <= 10 LOOP
    RAISE NOTICE '% x % = %', numero, multiplicador, (numero * multiplicador);
    multiplicador := multiplicador + 1;
  END LOOP;
END $$;


/*
3 - Escriba una funcion PL/pgSQL que convierta de dolares a moneda nacional.
    La funcion debe recibir dos parametros, cantidad de dolares y tasa de cambio.
    Al final debe retornar el monto convertido a moneda nacional.
*/
DO $$
DECLARE
  cantidad_dolares FLOAT := 100;
  tasa_cambio FLOAT := 0.82;
  cantidad_euros FLOAT;
BEGIN
  cantidad_euros := cantidad_dolares * tasa_cambio;
  RAISE NOTICE 'Cantidad de dolares: %', cantidad_dolares;
  RAISE NOTICE 'Tasa de cambio: %', tasa_cambio;
  RAISE NOTICE 'Cantidad de euros: %', cantidad_euros;
END $$;

/*

4 - Escriba una funcion PL/pgSQL que reciba como parametro el monto de un prestamo,
    su duracion en meses y la tasa de interes, retornando el monto de la cuota a pagar.
    Aplicar el metodo de amortizacion frances.
*/

DO $$
DECLARE
  monto_prestamo NUMERIC := 100000;
  duracion_meses INTEGER := 120;
  tasa_interes NUMERIC := 0.01;
  cuota NUMERIC;
  interes_mensual NUMERIC := tasa_interes / 12;
  factor NUMERIC := (1 + interes_mensual)^duracion_meses;
BEGIN
  cuota := (monto_prestamo * interes_mensual * factor) / (factor - 1);
  RAISE NOTICE 'La cuota mensual a pagar es: %', cuota;
END $$;
