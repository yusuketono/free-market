document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //カテゴリのフォームが無いなら以降実行しない。

  function buildCategoryForm(categories) { // 子孫カテゴリのフォームを組み立てる
    let options = "";
    categories.forEach(function (category) { // カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
      options += `
                  <option value="${category.id}">${category.name}</option>
                 `;
    });

    const html = `
                  <select required="required" class="select-category" id="parent-category" name="item[category_id]">
                    <option value="">---</option>
                    ${options}
                  </select>
                 `;
    return html;
  }
  /////////buildCategoryForm()ここまで/////////

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
        console.table(categories);

        const html = buildCategoryForm(categories);
        console.log(html);

      })
      .fail(function () {
        alert('error');
      })
  });
});