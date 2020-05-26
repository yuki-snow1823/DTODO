import AddTodo from '@/components/AddTodo'
import {
  mount,
  createLocalVue
} from '@vue/test-utils'
import Vuex from 'vuex';
import * as store from '@/store'

// let wrapper

const localVue = createLocalVue();
localVue.use(Vuex);

// let store;


describe('フォームのテスト', () => {
  beforeEach(() => {
    store = new Vuex.Store({
     store
    })
  })

  const wrapper = mount(AddTodo, { store, localVue });

  test("フォームにタスクポイントがセットされること", () => {
    wrapper.find('input[type="text"]').setValue(1)
    expect(wrapper.vm.todo.point).toBe("1")
  })

  test("フォームにタイトルがセットされること", () => {
    wrapper.find('#todo-title').setValue("test title")
    expect(wrapper.vm.todo.title).toBe("test title")
  })

  test("親コンポーネントにイベントが渡せること", () => {
    wrapper.find(".todo-btn").trigger("click");
    expect(store.state.currentUser).toBe(1)
  })

  test("親コンポーネントにイベントが渡せること", () => {
    wrapper.vm.$emit('submit')
    expect(wrapper.emitted().submit).toBeTruthy()
  })
})
