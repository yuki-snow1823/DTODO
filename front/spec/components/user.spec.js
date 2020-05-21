import user from "@/pages/user";
import { mount, createLocalVue } from "@vue/test-utils";
import Vuex from "vuex";
import * as store from "@/store";

let wrapper;
let vuetify;

const localVue = createLocalVue();
localVue.use(Vuex);

beforeEach(() => {
  vuetify = new Vuetify();
  wrapper = mount(user, {
    propsData: {
      experience_point: "",
      show1: false,
      show2: false,
      error: "",
      showContent: false
    },
    store: store,
    localVue,
    vuetify
  });
});

describe("AddTodoに関するテスト", () => {
  test("TODOが追加されること", () => {
    wrapper.find('input[type="text"]').setValue(1);
    expect(wrapper.vm.todo.point).toBe("1");
  });
});
