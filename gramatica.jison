/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%

"Evaluar"           return 'REVALUAR';
";"                 return 'PTCOMA';
"("                 return 'PARIZQ';
")"                 return 'PARDER';
"["                 return 'CORIZQ';
"]"                 return 'CORDER';

"+"                 return 'MAS';
"-"                 return 'MENOS';
"*"                 return 'POR';
"/"                 return 'DIVIDIDO';

/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

[0-9]+("."[0-9]+)?\b    return 'DECIMAL';
[0-9]+\b                return 'ENTERO';

<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex
%{
	var contador = 0;
%}
/* Asociación de operadores y precedencia */

%left 'MAS' 'MENOS'
%left 'POR' 'DIVIDIDO'
%left UMENOS

%start ini

%% /* Definición de la gramática */

ini
	: instrucciones EOF {
		return $1;
	}
;

instrucciones
	: instrucciones instruccion { 
		var padre = new Nodo("INTRUCCIONES","",0,0,contador);
		contador++;
		padre.addHijo($1);
		contador++;
		padre.addHijo($2);
		contador++;
		$$ = padre;
		}
	| instruccion{
		var padre = new Nodo("INTRUCCIONES","",0,0,contador)
		contador++;
		padre.addHijo($1);
		contador++;
		$$ = padre;
		}
	| error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

instruccion
	: REVALUAR CORIZQ expresion CORDER PTCOMA {
		var padre = new Nodo("INTRUCCION","",0,0,contador++);
		contador++;
		var Evaluar = new Nodo("Evaluar",$1,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(Evaluar);
		contador++;
		var corizq = new Nodo("corizq",$2,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(corizq);
		contador++;	
		padre.addHijo($3);
			contador++;
		var corder = new Nodo("corder",$4,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(corder);
contador++;
		var puntocoma = new Nodo("puntocoma",$5,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(puntocoma);
contador++;
		$$ = padre;
		//console.log('El valor de la expresión es: ' + $3);
	}
;

expresion
	: MENOS expresion %prec UMENOS  { $$ = $2 *-1;  
		var padre = new Nodo("EXPRESION","",0,0,contador);
		contador++;
		var menos = new Nodo("menos",$1,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(menos);
		contador++;
		
		padre.addHijo($2); 
		contador++;
		$$ = padre;
		}
	| expresion MAS expresion       { $$ = $1 + $3; 
		var padre = new Nodo("EXPRESION","",0,0,contador);
		contador++;
		padre.addHijo($1); 
		contador++;
		var mas = new Nodo("mas",$2,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(mas);
		contador++;
		padre.addHijo($3);
		contador++;
		$$ = padre;
		}
	}
	| expresion MENOS expresion     { $$ = $1 - $3;
		var padre = new Nodo("EXPRESION","",0,0,contador);
		contador++;
		padre.addHijo($1);
		contador++; 
		var menos = new Nodo("menos",$2,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(menos);
		contador++;
		padre.addHijo($3);
		contador++;
		$$ = padre;
	 }
	| expresion POR expresion       { $$ = $1 * $3; 
		var padre = new Nodo("EXPRESION","",0,0,contador);
		contador++;
		padre.addHijo($1); 
		contador++;
		var por = new Nodo("por",$2,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(por);contador++;
		padre.addHijo($3);
		contador++;
		$$ = padre;
	}
	| expresion DIVIDIDO expresion  { $$ = $1 / $3; 
		var padre = new Nodo("EXPRESION","",0,0,contador);
		contador++;
		padre.addHijo($1); 
		contador++;
		var dividido = new Nodo("dividido",$2,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(dividido);
		contador++;
		padre.addHijo($3);
		contador++;
		$$ = padre;
	}
	| ENTERO                        { $$ = Number($1);
		var padre = new Nodo("EXPRESION","",0,0,contador);
		contador++;
		var entero = new Nodo("entero",$1,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(entero);
		contador++;
		$$ = padre;
	 }
	| DECIMAL                       { $$ = Number($1);
		var padre = new Nodo("EXPRESION","",0,0,contador);
		contador++;
		var decimal = new Nodo("decimal",$1,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(decimal);
		contador++;
		$$ = padre;
	
	 }
	| PARIZQ expresion PARDER       { $$ = $2;
		var padre = new Nodo("EXPRESION","",0,0,contador);
		contador++;
		var parizq = new Nodo("parizq",$1,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(parizq);
		contador++;
		padre.addHijo($2);
		contador++;
		var parder = new Nodo("parder",$1,this._$.first_line,this._$.first_column,contador);
		padre.addHijo(parder);
		contador++;
		$$ = padre;
	 }
;