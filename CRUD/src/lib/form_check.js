// Verificação dos requisitos de senha

// Campos
const input_senha = document.getElementById("input-nova-conta-senha");
const mostrar_senha = document.getElementById("input-nova-conta-mostrar-senha");

const verif_maiuscula = document.getElementById("verif-maiuscula");
const verif_minuscula = document.getElementById("verif-minuscula");
const verif_digito = document.getElementById("verif-digito");
const verif_especial = document.getElementById("verif-especial");
const verif_caracteres = document.getElementById("verif-caracteres");

// Mostrar senha
mostrar_senha.addEventListener("click", () => {
    if (input_senha.type === "password") {
        input_senha.type = "text";
    }
    else {
        input_senha.type = "password";
    }
});

// Alterar a cor de acordo com o matching
const requisito_aceito = (requisito) => {
    requisito.classList.remove("verif-negado");
    requisito.classList.add("verif-aceito");
}
const requisito_negado = (requisito) => {
    requisito.classList.remove("verif-aceito");
    requisito.classList.add("verif-negado");
}

// Verificação de matching
input_senha.onkeyup = () => {
    // Regex
    const maiuscula = /[A-Z]/g;
    const minuscula = /[a-z]/g;
    const digito = /[0-9]/g;
    const especial = /[@$!%*?&]/g;

    let senha = input_senha.value;

    senha.match(maiuscula) ? requisito_aceito(verif_maiuscula) : requisito_negado(verif_maiuscula);
    senha.match(minuscula) ? requisito_aceito(verif_minuscula) : requisito_negado(verif_minuscula);
    senha.match(digito) ? requisito_aceito(verif_digito) : requisito_negado(verif_digito);
    senha.match(especial) ? requisito_aceito(verif_especial) : requisito_negado(verif_especial);
    senha.trim().length >= 8 ? requisito_aceito(verif_caracteres) : requisito_negado(verif_caracteres);
}