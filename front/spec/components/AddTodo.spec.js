import AddTodo from '@/components/AddTodo'
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
import Vuex from 'vuex';
// import * as store from '@/store'
import state from "@/store/state";
import mutations from "@/store/mutations";
import actions from "@/store/actions";

// let wrapper

const localVue = createLocalVue();
localVue.use(Vuex);

let store;

describe('フォームのテスト', () => {
  beforeEach(() => {
    store = new Vuex.Store({
      state,
      mutations,
      actions
    });
  })

  const handleSubmit = jest.fn();
  const wrapper = mount(AddTodo, { store, localVue, methods: { handleSubmit } });
  // wrapper.setProps({ todo: store.state.currentUser.todo })

  test("フォームにタスクポイントがセットされること", () => {
    wrapper.find('input[type="text"]').setValue(1)
    expect(wrapper.vm.todo.point).toBe("1")
  })

  test("フォームにタイトルがセットされること", () => {
    wrapper.find('#todo-title').setValue("test title")
    expect(wrapper.vm.todo.title).toBe("test title")
  })

  test("タイトルとタスクポイントをセットしてボタンを押すと、TODOが追加されること", () => {
    wrapper.find('input[type="text"]').setValue(1);
    wrapper.find("#todo-title").setValue("test title");
    wrapper.find(".todo-btn").trigger("click");
    expect(store.state.currentUser).toBe(1)
  })

  test("親コンポーネントにイベントが渡せること", () => {
    wrapper.vm.$emit('submit')
    expect(wrapper.emitted().submit).toBeTruthy()
  })
})
