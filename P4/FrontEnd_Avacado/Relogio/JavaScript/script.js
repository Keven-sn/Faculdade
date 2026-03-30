function atualizarRelogio(){

    const agora = new Date();

    const horas = agora.toLocaleTimeString("pt-BR", { 
        timeZone: "America/Sao_Paulo",
        hour: "2-digit"
    });

    const minutos = agora.toLocaleTimeString("pt-BR", { 
        timeZone: "America/Sao_Paulo",
        minute: "2-digit"
    });

    const segundos = agora.toLocaleTimeString("pt-BR", { 
        timeZone: "America/Sao_Paulo",
        second: "2-digit"
    });

    document.getElementById("horas").textContent = horas;
    document.getElementById("minutos").textContent = minutos;
    document.getElementById("segundos").textContent = segundos;
}

setInterval(atualizarRelogio, 1000);

atualizarRelogio();