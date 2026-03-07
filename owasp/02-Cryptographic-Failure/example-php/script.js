
document.getElementById('showtoken').addEventListener('click', function(){
    alert(document.cookie.replace(/(?:(?:^|.*;\s*)token\s*\=\s*([^;]*).*$)|^.*$/, "$1"));
});
