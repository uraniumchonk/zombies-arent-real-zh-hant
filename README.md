# Zombies Aren't Real 繁體中文翻譯包

> 適用版本：**v0.43.1**（2026-11-16 更新）
> 遊戲：[Zombies Aren't Real](https://store.steampowered.com/app/5185890/)（Steam）

一款殭屍城防策略遊戲的**完整繁體中文介面翻譯**，含自製中文字體，無缺字、無亂碼。

---

## 功能

- **2819 個介面文字**全數翻譯：主選單、設定、HUD、提示、戰鬥訊息
- **7 個突變因子**（Mutator）名稱與說明
- **13 張戰役地圖**名稱
- **自製繁體中文字體**：Noto Sans CJK TC 子集（SIL OFL 授權），涵蓋 Big5 全字集＋簡繁常用字，約 1.4 萬 glyph
- **不碰存檔**：進度、解鎖、設定完全保留
- **不碰執行檔**：無破解、無注入、無 DLL

## 下載

到 [Releases](https://github.com/uraniumchonk/zombies-arent-real-zh-hant/releases) 下載最新 zip，或直接 clone 本 repo。

## 安裝

1. 解壓 zip 到任意位置（**路徑不要有中文或特殊字元**）
2. 雙擊 `一鍵安裝還原.bat`
3. 腳本會自動偵測遊戲目錄；偵測不到就手動貼上（含 `zombies-arent-real.exe` 的資料夾）
4. 安裝完成後啟動遊戲 → **設定 → 語言 → 選「繁體中文」**

## 遊戲更新後

遊戲是 Early Access，更新會覆蓋翻譯檔。**更新後重跑 `一鍵安裝還原.bat`** 即可還原繁體中文（存檔不受影響）。

## 卸載（還原英文）

雙擊 `卸載還原英文.bat`，會從遊戲目錄內的 `_zh-Hant_backup` 備份還原英文原版，並移除 `zh-Hant.lang`。

> 若備份資料夾不存在（例如未用本包安裝），請改用 Steam：右鍵遊戲 → 屬性 → 已安裝的檔案 → **驗證遊戲檔案完整性**。

## 技術說明

- 遊戲偵測中文字體是靠**檔名** `NotoSansSC-Subset.otf`（非內容）。本包以自製繁體字體取代該檔名，故中文完整顯示。
- 本包**不含遊戲原始檔案**；安裝時自動備份到遊戲目錄的 `_zh-Hant_backup`，供卸載還原。
- 若 Steam 提示「檔案已修改」屬正常現象，不影響遊玩。

## 檔案結構

```
一鍵安裝還原.bat      安裝／更新後還原
卸載還原英文.bat      卸載（從本地備份還原英文）
說明.txt              簡易說明
zh-hant/              繁體中文檔案
├── lang/zh-Hant.lang
├── fonts/cjk/NotoSansSC-Subset.otf
├── mutators/*.ini
└── campaigns/*.cmp + order.txt
```

## 注意事項

- 本包僅供**個人使用與非商業分享**，請勿商業販售
- 翻譯為社群貢獻，如有錯譯歡迎提 Issue
- 本專案與遊戲官方（JoGameDev）無關
