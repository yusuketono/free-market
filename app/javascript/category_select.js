document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //カテゴリのフォームが無いなら以降実行しない。

  $(".input-field-main").on("change", ".select-category", function () { //カテゴリが選択された時
    const category_id = $(this).val();
    console.log("選択されたカテゴリのID:", category_id);
    $.ajax({
      url: "/api/categories",
      type: "GET",
      data: {
        category_id: category_id
      },
      dataType: 'json',
    }).done(function (categories) {
      console.log("success")
    })
    .fail(function () {
      alert('error');
    })
  });
});