# Introduction to Advection in 1-D

Vamos abordar neste tutorial a implementação de um integrador para a equação de
advecção nas suas formas linear e não linear. Como este é o primeiro *bloco* da
construção da equação de Navier-Stokes que almejamos alcançar ao final do livro
texto, vamos clarificar alguns pontos sobre a metodologia que será empregada.

O leitor que já tenha estudado o tópico através de outras fontes, como
[CFDPython](https://github.com/barbagroup/CFDPython), mais conhecido como *12
passos para Navier Stokes* vai observar que nossos códigos são mais estruturados
e menos explícitos. Isso vem da nossa observação de que existe uma pletora de
fontes instruindo o básico de programação científica, mas faltam fontes aonde
não somente as equações são abordadas. É de nossa experiência o excesso de
cientistas e engenheiros que vieram a aprender a estruturar um programa
tardivamente, o que resulta em uma infinidade de repositórios com código que,
embora às vezes funcional, é praticamente impossível de se realizar a manutenção
ou mesmo utilizar.

Dessa crítica ao *status quo*, vamos ao longo desta série não somente resolver
os problemas de uma ótica numérica, mas também progressivamente *pensar antes de
programar* a forma do programa que desejamos conceber. O estudante que se
engajar nessas práticas sem a menor dúvida terá uma carreira técnica de maior
sucesso e performance que os demais.

Aqui nos deparamos com um primeiro *conundrum*: uma interface interativa como
Pluto não é o meio ideal para se conceber um programa a ser mantido ao longo dos
anos. Esse tipo de documento é perfeito para realizar demonstrações e usar
interfaces de implementações mais complexas fornecidas através de pacotes. Vamos
nesse primeiro momento ignorar esse fato porque, embora buscamos transmitir o
conhecimento de como conceber um programa de qualidade, seríamos frustrados por
uma tentativa de ensinar isso diretamente com a concepção de pacotes, tema que é
abordado anexamente ao livro texto.

No que se segue neste *notebook* (vamos aceitar este anglicismo eventual ao
longo do texto) e nos subsequentes adotaremos uma estrutura típica. Começamos
com uma descrição do problema que desejamos resolver a as funcionalidades
almejadas. Com isso podemos pensar nas ferramentas que vamos necessitar e como
dita a boa prática importá-las logo no início do programa. Em seguida provemos
todo o código que é auxiliar ao problema numérico, como por exemplo a geração de
gráficos, de maneira a eliminar suas interferências na leitura do código
principal. Finalmente concebemos o código com o conteúdo matemático abordado e
seguimos com um programa de aplicação. Essa forma será empregada nos demais
*notebooks* sem que tenhamos que repetir essa descrição.