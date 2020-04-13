import AddTodo from "@/components/AddTodo";
import { mount } from "@vue/test-utils";
// Vue.component('add-todo', AddTodo);

describe('AddTodo', () => {
  // コンポーネントがマウントされ、ラッパが作成されます。
  const wrapper = mount(AddTodo)

  // 要素の存在を確認することも簡単です
  it('追加ボタンが存在する', () => {
    expect(wrapper.contains('v-hover')).toBe(true)
  })
})
