import AddTodo from "@/components/AddTodo";
import { mount, createLocalVue } from "@vue/test-utils";
import Vuex from "vuex";

const localVue = createLocalVue();

localVue.use(Vuex);

let store;

describe("フォームのテスト", () => {
  beforeEach(() => {
    store = new Vuex.Store({
      state: {
        currentUser: {
          user: {
            id: 1
          },
          todos: []
        }
      },
      mutations: {
        submit(state, todo) {
          state.currentUser.todos.push(todo);
        }
      }
    });
  });

  test("フォームにタイトルがセットされること", () => {
    const wrapper = mount(AddTodo, { store, localVue });
    wrapper.find("#todo-title").setValue("test title");
    expect(wrapper.vm.todo.title).toBe("test title");
  });

  test("タイトルとタスクポイントをセットしてボタンを押すと、TODOが追加されること", () => {
    const wrapper = mount(AddTodo, { store, localVue });
    // v-selectに値が入らないので、このようにしています。
    wrapper.vm.todo.point = 1;
    wrapper.find("#todo-title").setValue("test title");
    wrapper.find(".todo-btn").trigger("click");
    expect(store.state.currentUser.todos[0].title).toBe("test title");
  });

  test("親コンポーネントにイベントが渡せること", () => {
    const wrapper = mount(AddTodo, { store, localVue });
    wrapper.vm.$emit("submit");
    expect(wrapper.emitted().submit).toBeTruthy();
  });
});
