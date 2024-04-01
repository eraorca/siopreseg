#--------------------------------------------------------------------------------------------------
#-- (ɔ) CopyLeft Emiro Reyes Alvarado, 2024
#-- UI4-ESCO - 3302702
#-- Este programa es software libre: Puede distribuirlo y/o modificarlo bajo los términos de la
#-- versión 3 de la licencia GNU (General Public License) publicada por la Free Software Foundation 
#-- (http://www.gnu.org/licenses/).
#--
#-- Programa:     fibonacci.asm [E01]
#--
#-- Autor:        Emiro Reyes Alvarado
#--
#-- Creado:       sábado 30 de marzo de 2024 - 03:40 PM
#--
#-- Modificado:   domingo 31 de marzo de 2024 - 08:32 PM
#--
#-- Función:      Asumiendo que la serie de 'fibonacci' [E02] empieza en 1, y sabiendo que sus dos
#--               primeros términos son 1, este programa solicita al usuario un número entre
#--               ('CI_ADT_RANGMIN' + 1) y ('CI_ADT_TAMATAB' + 1 ), para generar y almacenar esa
#--               cantidad de términos en la tabla 't_tabla', que luego imprime en pantalla.
#--
#--               [1]  Inicia la tabla 't_tabla', que puede almacenar hasta ('CI_ADT_TAMATAB' + 1 )
#--                    términos de la serie de 'fibonacci'.
#--
#--               [2]  Solicita al usuario definir la cantidad de términos de la serie que se va a
#--                     generar, suministrando un número entre ('CI_ADT_RANGMIN' + 1) y
#--                     ('CI_ADT_TAMATAB' + 1 ).
#--
#--               [3]  Inicia un ciclo en el que obtiene la respuesta del usuario y...
#--
#--                    <3.1>  Si el número suministrado está entre ('CI_ADT_RANGMIN' + 1) y
#--                           ('CI_ADT_TAMATAB' + 1 )...
#--
#--                    <3.1.1>  Notifica al usuario, almacena la cantidad de términos de la serie,
#--                             y termina el ciclo.
#--
#--                    <3.2>  Si no...
#--
#--                    <3.2.1>  Notifica al usuario, y le pide nuevamente definir la cantidad de
#--                             términos de la serie.
#--
#--               [4]  Genera los dos primeros términos y los almacena en la tabla.
#--
#--               [5]  Inicia un ciclo en el que genera el resto de términos de la serie, usando
#--                    para cada uno los dos anteriores, y los almacena en la tabla.
#--
#--               [6]  Apunta al inicio de la tabla y recupera su tamaño, cosas que perdió en el
#--                    paso anterior.
#--
#--               [7]  Inicia un ciclo que termina cuando llegue al final de la tabla, en el que
#--                    imprime sus elementos de la siguiente manera...
#--
#--                    <7.1>  Imprime el siguiente elemento de la tabla.
#--
#--                    <7.2>  Si estamos en el último elemento de la tabla no imprime el separador
#--                           'CS_SPS_SEPARADOR'.
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
#--                       utiliza durante el ciclo que recorre la tabla e imprime los términos de
#--                       la serie.
#--
#--               $t1 ::= Se utiliza para almacenar temporalmente el resultado de las operaciones
#--                       lógicas de las instrucciones condicionales del programa.
#--
#--               $t2 ::= Se utiliza para almacenar temporalmente el resultado de las operaciones
#--                       lógicas de las instrucciones condicionales del programa.
#--    
#--               $s0 ::= Apuntador del elemento actual de la tabla 't_tabla'.  Al inicio apunta al
#--                       primer elemento de la tabla, después apunta al elemento actual de la
#--                       tabla.
#--
#--               $s1 ::= Al inicio del programa almacena el tamaño de la tabla 'CI_ADT_TAMATAB'
#--                       (desde cero).
#--
#--                       Al terminar el ciclo en el que el usuario define la cantidad de términos
#--                       de la serie (que también es el nuevo tamaño de la tabla), almacena el
#--                       nuevo tamaño.
#--
#--                       Cuando se generan los dos primeros términos, se decrementa en 2 su valor
#--                       para actuar como testigo del ciclo en el que se calculan los demás
#--                       términos de la serie.
#--
#--                       Durante el ciclo que calcula los demás términos de la serie, se
#--                       decrementa en 1 su valor para actuar como testigo.
#--
#--                       Recuperado su valor como tamaño de la tabla desde el registro $s3, se
#--                       decrementa nuevamente su valor en 1 durante el ciclo que recorre la tabla
#--                       e imprime los términos de la serie.
#--
#--               $s2 ::= Mantiene el número recien suministrado por el usuario.
#--
#--               $s3 ::= Preserva la cantidad de términos de la serie (que también es el tamaño de
#--                       la tabla).
#--
#--               $s4 ::= Almacena el término padre (n-2) de la serie.
#--
#--               $s5 ::= Almacena el término hijo (n-1) de la serie.
#--
#--               $s6 ::= Almacena el término actual de la serie, calculado a partir de los
#--                       términos padre e hijo.
#--
#-- Retorna:      Nada.
#--
#-- Argumentos:   Ninguno.
#--
#-- Uso:          Se ensambla y ejecuta desde el Ambiente Integrado de Desarrollo MARS 4.5 [E03].
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
#--[E02] "Sucesión de Fibonacci" en "Wikipedia" [Visitado el domigo, 31 de marzo de 2024]
#--      [html] <--[Internet]
#--                 |
#--                 +--> [https://es.wikipedia.org/wiki/Sucesi%C3%B3n_de_Fibonacci]
#--
#--[E03] "MARS (MIPS Assembler and Runtime Simulator)" en "Missouri State University > mars" [Visitado el domigo, 31 de marzo de 2024]
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
      .eqv CI_ADT_RANGINF 0    # Rango inferior de la tabla.
      .eqv CI_ADT_UNO     1    # El primer elemento de la tabla.
      .eqv CI_ADT_RANGMIN 2    # Rango mínimo de la tabla.
      .eqv CI_ADT_RANGMAX 21   # Rango máximo de la tabla.
      .eqv CI_ADT_TAMAELE 4    # Tamaño de cada entrada de la tabla.
      .eqv CI_ADT_TAMATAB 19   # Tamaño de la tabla.
      
#--------------------------------------------------------------------------------------------------
#            [ADS]------- Atributos de la serie
#-------------^^^---------^---------^-----^-------------------------------------------------------- 
      .eqv CI_ADS_VADOPRIT   1    # valor de los dos primeros términos.
#                 ^-^-^--^----------^------------^---^--------^--------

#                [DPD]--- Direccionamiento por desplazamiento
#                 ^^^-----^----------------^---^-------------

      .eqv CI_ADS_DPD_ATERPA 0    # Desplazamiento al término padre.
#                     ^^--^------------------------^--^-------^-----

      .eqv CI_ADS_DPD_ATERHI 4    # Desplazamiento al término hijo.
#                     ^^--^------------------------^--^-------^----

      .eqv CI_ADS_DPD_ATERAC 8    # Desplazamiento al término actual.
#                     ^^--^------------------------^--^-------^------
  
#--------------------------------------------------------------------------------------------------
#            [SPS]------- Sufijos, prefijos, separadores
#-------------^^^---------^--------^---------^-----------------------------------------------------
      .eqv CS_SPS_SEPARADOR  ", "
      
#--------------------------------------------------------------------------------------------------
#            [MSG]------- Mensajes para el usuario
#--------------------------------------------------------------------------------------------------
      .eqv CS_MSG_01     "Suministre la cantidad de términos de la serie (de 3 a 20):\n"
      .eqv CS_MSG_02     "--> "
      .eqv CS_MSG_03     "\nLa serie va a tener "
      .eqv CS_MSG_04     " términos\n"
      .eqv CS_MSG_05     "\n[ Error ] El valor suministrado no está en el rango permitido...\n"
      .eqv CS_MSG_06     "\n"
      .eqv CS_MSG_07     "\nLa serie generada es : "
      
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
      i_espacio:   .word CI_ADT_TAMATAB                     #+('CI_ADT_TAMATAB' + 1) términos de la
                                                            #+serie de 'fibonacci'.
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
      
#--------------------------------------------------------------------------------------------------
#--Manejo de excepciones
#--------------------------------------------------------------------------------------------------      
      
.kdata

#--------------------------------------------------------------------------------------------------
#            [MSG]------- Mensajes para el usuario
#--------------------------------------------------------------------------------------------------
      .eqv CS_MSG_08     "\n[ Error ] El valor suministrado no es un número, intente nuevamente por favor...\n"
      
#--------------------------------------------------------------------------------------------------
#            [Variables locales]-------
#--------------------------------------------------------------------------------------------------
      s_msg_08:    .asciiz CS_MSG_08        

.text

#--
#-- ***[1]
#--

      la   $s0, t_tabla                             # En esta dirección está la tabla 't_tabla'.
      la   $s1, i_espacio                           # En esta dirección está el tamaño de la tabla.
      lw   $s1, 0($s1)                              # Obtiene el tamaño de la tabla.

#--
#-- ***[2]
#--

      IMPRIMIR_CADENA (s_msg_01)                    # Solicita al usuario definir la cantidad de
      IMPRIMIR_CADENA (s_msg_02)                    #+términos de la serie que se va a generar.
      
#--
#-- ***[3]
#--

      ciclo_cuantos_terminos:
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
                  move $s3, $s2                     # Almacena la cantidad de términos de la serie
                  j iniciar_fibonacci               # Temina el ciclo.
              
                  #</3.1.1>              

          #</3.1>                
          #<3.2>
          
          si_no_1:                                  # ($s2 > CI_ADT_RANGMIN) && ($s2 < CI_ADT_RANGMAX)
                  
                  #<3.2.1>
                  
                  IMPRIMIR_CADENA (s_msg_05)        # Notifica al usuario.
                  IMPRIMIR_CADENA (s_msg_01)        # El valor suministrado no está en el rango, entonces Solicita
                  IMPRIMIR_CADENA (s_msg_02)        #+al usuario definir el tamaño de la tabla.                  
                  
                  #</3.2.1>
          
          #</3.2>
          
      j ciclo_cuantos_terminos                      # Siguiente ciclo.

#--
#-- ***[4]
#--

      iniciar_fibonacci:
          li   $s6, CI_ADS_VADOPRIT                # Por definición los dos primeros términos de la serie valen 1.                                                   
          sw   $s6, CI_ADS_DPD_ATERPA($s0)         # Almacena en la tabla el primero, que se convierte en el término padre.
          sw   $s6, CI_ADS_DPD_ATERHI($s0)         # Almacena en la tabla el segundo, que se convierte en el término hijo.
          addi $s1, $s1, -2                        # Ajusta el tamaño efectivo de la tabla, que ya tiene ocupados dos elementos.
          

#--
#-- ***[5]
#--

      ciclo_calcular_fibonacci:
          lw   $s4, CI_ADS_DPD_ATERPA($s0)         # Obtiene el término padre para este término de la serie (F[n-2]).
          lw   $s5, CI_ADS_DPD_ATERHI($s0)         # Obtiene el término hijo para este término de la serie (F[n-1]).
          add  $s6, $s5, $s4                       # Calcula este término de la serie (F[n] = F[n-1] + F[n-2]),
          sw   $s6, CI_ADS_DPD_ATERAC($s0)         #+y lo almacena en la tabla.
          addi $s0, $s0, CI_ADT_TAMAELE            # Apunta al siguiente elemento de la tabla que ahora es el término padre para
                                                   #+el siguiente término de la serie.
          addi $s1, $s1, -1                        # Ajusta el tamaño efectivo de la tabla, que ya tiene ocupado otro elemento.
          bgtz $s1, ciclo_calcular_fibonacci       # Repite el ciclo hasta que el tamaño efectivo de la tabla sea cero.

#--
#-- ***[6]
#--

          la   $s0, t_tabla                         # Apunta al primer elemetno de la tabla. 
          move $s1, $s3                             # Recuerda el tamaño de la tabla.
          
          IMPRIMIR_CADENA (s_msg_07)

#--
#-- ***[7]
#--

      ciclo_imprimir_serie:
          beq $s1,  $zero, salir                    # Termina el ciclo si llegamos al final de la tabla.
          
          #<7.1>
          
          lw  $t0,  ($s0)                           # Obtiene el valor del elemento actual de la tabla.
          IMPRIMIR_ENTERO ($t0)                     # Imprime el valor.
          
          #</7.1>
          #<7.2>
          
          si_2:                                     # ($s1 > CI_ADT_UNO)
              sgt $t1, $s1, CI_ADT_UNO              # En $t1 el resultado del booleano ($s1 > CI_ADT_UNO).
              beqz $t1, fin_si_2                    # Si estamos en el último elemento de la tabla no
                                                    #+imprime el separador.
                  IMPRIMIR_CADENA (s_separador)     # Imprime el separador.
                  
          fin_si_2:                                 # ($s1 > CI_ADT_UNO)          
          
          #</7.2>
          
          addi $s1, $s1, -1                         # Decrementa el contador del ciclo.
          addi $s0, $s0, CI_ADT_TAMAELE             # Apunta al siguiente elemento de la tabla.
                  
      j ciclo_imprimir_serie                        # Siguiente ciclo.          

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
      IMPRIMIR_CADENA (s_msg_08)                    # Notifica al usuario, y le solicita suministrar nuevamente
      IMPRIMIR_CADENA (s_msg_02)                    #+el dato.
      move $v0,$k0                                  # Restaurar $v0
      move $a0,$k1                                  # Restaurar $a0      
      eret                                          # Retorna a la instrucción que produjo la excepción.          
