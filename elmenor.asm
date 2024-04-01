#--------------------------------------------------------------------------------------------------
#-- (ɔ) CopyLeft Emiro Reyes Alvarado, 2024
#-- UI4-ESCO - 3302702
#-- Este programa es software libre: Puede distribuirlo y/o modificarlo bajo los términos de la
#-- versión 3 de la licencia GNU (General Public License) publicada por la Free Software Foundation 
#-- (http://www.gnu.org/licenses/).
#--
#-- Programa:     elmenor.asm [E01]
#--
#-- Autor:        Emiro Reyes Alvarado
#--
#-- Creado:       sábado 30 de marzo de 2024 - 03:39 PM
#--
#-- Modificado:   domingo 31 de marzo de 2024 - 09:00 AM
#--
#-- Función:      Solicita al usuario hasta ('CI_ADT_TAMATAB' + 1 ) números enteros positivos,
#--               calcula el menor de todos y lo imprime en pantalla.
#--
#--               [1]  Inicia la tabla 't_tabla', que puede almacenar hasta ('CI_ADT_TAMATAB' + 1 )
#--                    números enteros positivos.
#--
#--               [2]  Solicita al usuario definir el tamaño de la tabla, suministrando un número
#--                    entre ('CI_ADT_RANGMIN' + 1) y ('CI_ADT_TAMATAB' + 1 ).
#--
#--               [3]  Inicia un ciclo en el que obtiene la respuesta del usuario y...
#--
#--                    <3.1>  Si el número suministrado está entre ('CI_ADT_RANGMIN' + 1) y ('CI_ADT_TAMATAB' + 1 )...
#--
#--                    <3.1.1>  Notifica al usuario, ajusta el tamaño de la tabla, y termina el
#--                             ciclo.
#--
#--                    <3.2>  Si no...
#--
#--                    <3.2.1>  Notifica al usuario, y le pide nuevamente definir el tamaño de la
#--                             tabla.
#--
#--               [4]  Ahora inicia un ciclo que termina cuando la tabla esté llena, en el que...
#--
#--                    <4.1>  Solicita al usuario definir este elemento de la tabla.
#--
#--                    <4.2>  Obtiene la respuesta del usuario y la almacena en el elemento actual
#--                           de la tabla.
#--
#--               [5]  Apunta al inicio de la tabla y recupera su tamaño, cosas que perdió en el
#--                    paso anterior.
#--
#--                    Asume que el primer elemento de la tabla es el menor.
#--
#--               [6]  Inicia un ciclo que termina cuando llegue al final de la tabla, en el que
#--                    imprime sus elementos y calcula el menor de todos, de la siguiente manera...
#--
#--                    <6.1>  Imprime el siguiente elemento de la tabla.
#--
#--                    <6.2>  Si estamos en el último elemento de la tabla no imprime el separador
#--                           'CS_SPS_SEPARADOR'.
#--
#--                    <6.3>  Si el elemento actual es mayor o igual que el menor actual, no hace
#--                           nada.
#--
#--                           Si es menor, lo almacena en el menor actual.
#--
#--               [7]  Imprime el elemento menor de la tabla.
#--
#--               [8]  Termina el programa.
#--
#--               [9]  Aquí se llega cuando se produce una excepción porque el usuario suministró
#--                    un valor no numérico.
#--
#--                    El programa notifica al usuario y le solicita suministrar el valor
#--                    nuevamente.
#--
#--                    Después recupera el contexto de la ejecución, cuando se disparó la excepción,
#--                    y retorna a la instrucción que la originó, para continuar la ejecución
#--                    normal.
#--
#-- Registros:    $t0 ::= Almacena temporalmente el valor del elemento actual de la tabla.  Se
#--                       utiliza cuando se imprime la tabla y cuando se calcula el menor valor.
#--
#--               $t1 ::= Se utiliza para almacenar temporalmente el resultado de las operaciones
#--                       lógicas de las instrucciones condicionales del programa.
#--
#--               $t2 ::= Se utiliza para almacenar temporalmente el resultado de las operaciones
#--                       lógicas de las instrucciones condicionales del programa.
#--
#--               $t3 ::= Almacena el valor del menor elemento actual de la tabla.
#--
#--               $s0 ::= Apuntador del elemento actual de la tabla 't_tabla'.  Al inicio apunta al
#--                       primer elemento de la tabla, después apunta al elemento actual de la
#--                       tabla.
#--
#--               $s1 ::= Al inicio del programa almacena el tamaño de la tabla 'CI_ADT_TAMATAB'
#--                       (desde cero).  Al terminar el ciclo en el que el usuario define el tamaño
#--                       de la tabla, almacena el nuevo tamaño.  Durante el ciclo que llena la
#--                       tabla, se decrementa en 1 su valor para actuar como testigo.  Recuperado
#--                       su valor como tamaño de la tabla desde el registro $s3, se decrementa
#--                       nuevamente su valor en 1 durante el ciclo que imprime y calcula el menor
#--                       valor.
#--
#--               $s2 ::= Mantiene el número recien suministrado por el usuario.
#--
#--               $s3 ::= Mantiene una copia del tamaño de la tabla definido por el usuario.
#--
#--               $s4 ::= Se utiliza como contador de elementos de la tabla, para indicar al
#--                       usuario el número del elemento cuyo valor debe suministrar, durante el
#--                       ciclo que llena la tabla.
#--
#-- Retorna:      Nada.
#--
#-- Argumentos:   Ninguno.
#--
#-- Uso:          Se ensambla y ejecuta desde el Ambiente Integrado de Desarrollo MARS 4.5 [E02].
#--
#-- Versión:      1.00.00
#--------------------------------------------------------------------------------------------------
#                                            **  NOTAS  **
#--------------------------------------------------------------------------------------------------
#--Enlaces
#--[E01] Nte 030 - Nombres de archivos fuente
#--      [html] <--[Internet]
#--                 |
#--                 +--> [www.metalura.com.co/retina/docu/Notas Tecnicas/Nte 030/prd_0001.html]
#--
#--[E02] "MARS (MIPS Assembler and Runtime Simulator)" en "Missouri State University > mars" [Visitado el domigo, 31 de marzo de 2024]
#--      [html] <--[Internet]
#--                 |
#--                 +--> [https://courses.missouristate.edu/kenvollmar/mars/index.htm]
#--------------------------------------------------------------------------------------------------
#**  HISTORIA  ** **                               DESCRIPCION	                                 **
#--------------------------------------------------------------------------------------------------
#[AUT]-dd/mm/aaaa Actividad
#[AUT]-dd/mm/aaaa Actividad

.data

#--------------------------------------------------------------------------------------------------
#--Constantes y definiciones
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
#            [ADT]------- Atributos de la tabla
#-------------^^^---------^---------^-----^--------------------------------------------------------
      .eqv CI_ADT_RANGINF 0    # Rango inferior de la tabla 't_tabla'.
      .eqv CI_ADT_UNO     1    # El primer elemento de la tabla 't_tabla'.
      .eqv CI_ADT_RANGMIN 2    # Rango mínimo de la tabla 't_tabla'.
      .eqv CI_ADT_RANGMAX 11   # Rango máximo de la tabla 't_tabla'.
      .eqv CI_ADT_TAMAELE 4    # Tamaño de cada entrada de la tabla 't_tabla'.
      .eqv CI_ADT_TAMATAB 9    # Tamaño de la tabla 't_tabla'.
      
#--------------------------------------------------------------------------------------------------
#            [SPS]------- Sufijos, prefijos, separadores
#-------------^^^---------^--------^---------^-----------------------------------------------------
      .eqv CS_SPS_SEPARADOR  ", "
      
#--------------------------------------------------------------------------------------------------
#            [MSG]------- Mensajes para el usuario
#--------------------------------------------------------------------------------------------------
      .eqv CS_MSG_01     "Suministre el tamaño de la tabla (de 3 a 10):\n"
      .eqv CS_MSG_02     "--> "
      .eqv CS_MSG_03     "\nLa tabla tiene "
      .eqv CS_MSG_04     " elementos\n"
      .eqv CS_MSG_05     "Suministre el elemento "
      .eqv CS_MSG_06     " de la tabla:\n"
      .eqv CS_MSG_07     "\n[ Error ] El valor suministrado no está en el rango permitido...\n"
      .eqv CS_MSG_08     "\n"
      .eqv CS_MSG_09     "\nEl menor elemento de la tabla es : "
      
#--------------------------------------------------------------------------------------------------
#--Macros
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
#           [SALIR]------- Termina la ejecución del programa
#--------------------------------------------------------------------------------------------------
      .macro SALIR     
          li $v0, 10
          syscall          
      .end_macro
      
#--------------------------------------------------------------------------------------------------
#           [IMPRIMIR_ENTERO]------- Imprime en pantalla un número entero
#--------------------------------------------------------------------------------------------------
      .macro IMPRIMIR_ENTERO (%entero)
          li $v0, 1
          move $a0, %entero
          syscall
      .end_macro 
      
#--------------------------------------------------------------------------------------------------
#           [IMPRIMIR_CADENA]------- Imprime una cadena de caracteres en pantalla
#--------------------------------------------------------------------------------------------------
      .macro IMPRIMIR_CADENA (%cadena)
          li $v0, 4
          la $a0, %cadena
          syscall
      .end_macro
      
#--------------------------------------------------------------------------------------------------
#           [LEER_ENTERO]------- Lee un número entero desde la consola
#--------------------------------------------------------------------------------------------------
      .macro LEER_ENTERO
          li $v0, 5
          syscall
          move $s2, $v0
      .end_macro      


#--------------------------------------------------------------------------------------------------
#--Variables locales
#--------------------------------------------------------------------------------------------------
      t_tabla:     .word CI_ADT_RANGINF : CI_ADT_TAMATAB    # Tabla que almacena hasta 
      i_espacio:   .word CI_ADT_TAMATAB                     #+('CI_ADT_TAMATAB' + 1) números enteros
                                                            #+positivos suministrados por el usuario
                                                            #+desde la consola.
      i_uno:       .word CI_ADT_UNO                         # Representa el primer elemento de la
                                                            #+tabla.
      
      s_separador: .asciiz CS_SPS_SEPARADOR
      s_msg_01:    .asciiz CS_MSG_01
      s_msg_02:    .asciiz CS_MSG_02
      s_msg_03:    .asciiz CS_MSG_03
      s_msg_04:    .asciiz CS_MSG_04
      s_msg_05:    .asciiz CS_MSG_05
      s_msg_06:    .asciiz CS_MSG_06
      s_msg_07:    .asciiz CS_MSG_07
      s_msg_08:    .asciiz CS_MSG_08
      s_msg_09:    .asciiz CS_MSG_09
      
#--------------------------------------------------------------------------------------------------
#--Manejo de excepciones
#--------------------------------------------------------------------------------------------------      
      
.kdata

#--------------------------------------------------------------------------------------------------
#            [MSG]------- Mensajes para el usuario
#--------------------------------------------------------------------------------------------------
      .eqv CS_MSG_10 "\n[ Error ] El valor suministrado no es un número, intente nuevamente por favor...\n"
      
#--------------------------------------------------------------------------------------------------
#            [Variables locales]-------
#--------------------------------------------------------------------------------------------------
      s_msg_10:    .asciiz CS_MSG_10           

.text

#--
#-- ***[1]
#--

      la   $s0, t_tabla                             # En esta dirección está la tabla 't_tabla'.
      la   $s1, i_espacio                           # En esta dirección está el tamaño de la tabla.
      lw   $s1, 0($s1)                              # Obtiene el tamaño de la tabla.
      la   $s4, i_uno                               # Esta dirección representa el primer elemento
                                                    #+de la tabla.
      lw   $s4, 0($s4)                              # Inicia el contador de elementos de la tabla.

#--
#-- ***[2]
#--

      IMPRIMIR_CADENA (s_msg_01)                    # Solicita al usuario definir el tamaño de la
      IMPRIMIR_CADENA (s_msg_02)                    #+tabla.
#--
#-- ***[3]
#--

      ciclo_tama_tabla:
          LEER_ENTERO                               # Obtiene la respuesta del usuario.

          #<3.1>

          si_1:                                     # ($s2 > CI_ADT_RANGMIN) && ($s2 < CI_ADT_RANGMAX).
              sgt  $t1, $s2, CI_ADT_RANGMIN         # En $t1 el resultado del booleano ($s2 > CI_ADT_RANGMIN).
              slti $t2, $s2, CI_ADT_RANGMAX         # En $t2 el resultado del booleano ($s2 < CI_ADT_RANGMAX).
              and  $t1, $t1, $t2                    # En $t1 el resultado del booleano (($s2 > CI_ADT_RANGMIN) && ($s2 < CI_ADT_RANGMAX)).
              beqz $t1, si_no_1                     # Si el valor suministrado por el usuario está en el rango
                                                    #+permitido,
                                                                  
                  #<3.1.1>
              
                  IMPRIMIR_CADENA (s_msg_03)        # Notifica al usuario  
                  IMPRIMIR_ENTERO ($s2)
                  IMPRIMIR_CADENA (s_msg_04)
                  move $s1, $s2                     # Ajusta el tamaño de la tabla
                  move $s3, $s2                     # Preserva el nuevo tamaño de la tabla.
                  j ciclo_llenar_tabla              # Temina el ciclo.              
              
                  #</3.1.1>              

          #</3.1>
          #<3.2>
          
          si_no_1:                                  # ($s2 > CI_ADT_RANGMIN) && ($s2 < CI_ADT_RANGMAX)
                  
                  #<3.2.1>
                  
                  IMPRIMIR_CADENA (s_msg_07)        # Notifica al usuario.
                  IMPRIMIR_CADENA (s_msg_01)        # El valor suministrado no está en el rango, entonces Solicita
                  IMPRIMIR_CADENA (s_msg_02)        #+al usuario definir el tamaño de la tabla.                  
                  
                  #</3.2.1>
          
          #</3.2>
          
      j ciclo_tama_tabla                            # Siguiente ciclo.

#--
#-- ***[4]
#--

      ciclo_llenar_tabla:
          beq $s1,  $zero, continuar                # Termina el ciclo si llegamos al final de la tabla.
          
          #<4.1>
          
          IMPRIMIR_CADENA (s_msg_05)                # Solicita al usuario definir este elemento de la tabla
          IMPRIMIR_ENTERO ($s4)
          IMPRIMIR_CADENA (s_msg_06)
          IMPRIMIR_CADENA (s_msg_02)          
          
          #</4.1>
          #<4.2>
          
          LEER_ENTERO                               # Obtiene la respuesta del usuario.
          sw   $v0, ($s0)                           # La almacena en el elemento actual de la tabla.
          addi $s1, $s1, -1                         # Decrementa el contador del ciclo.
          addi $s0, $s0, CI_ADT_TAMAELE             # Apunta al siguiente elemento de la tabla.
          addi $s4, $s4, 1                          # Incrementa el contador de elementos de la tabla.
          
          #</4.2>
          
      j ciclo_llenar_tabla                          # siguiente ciclo.

#--
#-- ***[5]
#--

      continuar:
          la   $s0, t_tabla                         # En esta dirección está la tabla. 
          move $s1, $s3                             # Recuerda el tamaño de la tabla
          lw   $t3, ($s0)                           # Asume que el primer elemento de la tabla es
                                                    #+el menor.
          IMPRIMIR_CADENA (s_msg_08)

#--
#-- ***[6]
#--

      ciclo_tabla:
          beq $s1,  $zero, menor                    # Termina el ciclo si llegamos al final de la tabla.
          
          #<6.1>
          
          lw  $t0,  ($s0)                           # Obtiene el valor del elemento actual de la tabla.
          IMPRIMIR_ENTERO ($t0)                     # Imprime el valor.          
          
          #</6.1>
          #<6.2>
          
          si_2:                                     # ($s1 > CI_ADT_UNO)
              sgt $t1, $s1, CI_ADT_UNO              # En $t1 el resultado del booleano ($s1 > CI_ADT_UNO).
              beqz $t1, fin_si_2                    # Si estamos en el último elemento de la tabla no
                                                    #+imprime el separador.
                  IMPRIMIR_CADENA (s_separador)     # Imprime el separador.
                  
          fin_si_2:                                 # ($s1 > CI_ADT_UNO)          
          
          #</6.2>
          #<6.3>
          
          si_3:                                     # ($t0 >= $t3)
              bge $t0, $t3, fin_si_3                # Si el elemento actual es mayor o igual que el
                                                    #+menor actual, no tenemos un nuevo menor.
                  move $t3, $t0                     # Tenemos un nuevo manor actual.
              
          fin_si_3:
          
          #</6.3>
          
          
          addi $s1, $s1, -1                         # Decrementa el contador del ciclo.
          addi $s0, $s0, CI_ADT_TAMAELE             # Apunta al siguiente elemento de la tabla.
                  
      j ciclo_tabla                                 # Siguiente ciclo.

#--
#-- ***[7]
#--

     menor:
          IMPRIMIR_CADENA (s_msg_08)
          IMPRIMIR_CADENA (s_msg_09)
          IMPRIMIR_ENTERO ($t3)

#--
#-- ***[8]
#--

      salir:
          SALIR                                     # Termina el programa.
          
#--
#-- ***[9]
#--

.ktext 0x80000180
      move $k0,$v0                                  # Guardar $v0
      move $k1,$a0                                  # Guardar $a0
      IMPRIMIR_CADENA (s_msg_10)                    # Notifica al usuario, y le solicita suministrar nuevamente
      IMPRIMIR_CADENA (s_msg_02)                    #+el dato.
      move $v0,$k0                                  # Restaurar $v0
      move $a0,$k1                                  # Restaurar $a0      
      eret                                          # Retorna a la instrucción que produjo la excepción. 
