import Vuex from 'vuex'
import {
  mount,
  createLocalVue
} from "@vue/test-utils";
import * as store from '@/store'
import Hoge from "./Hoge.vue";

describe("Component", () => {
  test("is a Vue instance", () => {
    const wrapper = mount(Hoge);
    expect(wrapper.isVueInstance()).toBeTruthy();
  });
});
