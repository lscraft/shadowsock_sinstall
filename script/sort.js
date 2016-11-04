(function () {
    var changeStyle = function () {
        if ($("#sorting").get(0).className === "up") { $("#sorting").get(0).className = "down"; }
        else { $("#sorting").get(0).className = "up"; }
    };
    function judge(index) {
        var standard = -1;
        if ($("#sorting").get(0).className === "up") { standard = -standard; }
        return function (a, b) {
            if (a.children[index].innerText < b.children[index].innerText) { return -standard; }
            else if (a.children[index].innerText === b.children[index].innerText) { return 0; }
            else { return standard; }
        };
    }
    function actSort(dom) {
        var father_table = $(dom).closest("table");
        var arr_before = father_table.find("tr").toArray().slice(1);
        var arr_after = father_table.find("tr").clone().toArray().slice(1).sort(judge($("#sorting").index()));
        for (var i = 0; i < arr_before.length; i++) {
            arr_before[i].innerHTML = arr_after[i].innerHTML;
        }
    }
    function sortBegin() {
        if (document.getElementById('sorting') && 'sorting' !== this.id) { $("#sorting").removeClass("up down").get(0).id = ""; }
        this.id = "sorting";
        changeStyle();
        actSort(this);
    }
    $(function () {
        $("th").click(sortBegin);
    });
})();
