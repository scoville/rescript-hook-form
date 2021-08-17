import reactRefresh from "@vitejs/plugin-react-refresh";
import createReScriptPlugin from "@jihchi/vite-plugin-rescript";

export default {
  plugins: [createReScriptPlugin(), reactRefresh()],
  root: __dirname,
};
