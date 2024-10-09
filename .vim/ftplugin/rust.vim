" filetype: rust

if exists("b:AutoPairs")
    let b:AutoPairs=AutoPairsDefine({'\w\zs<': '>'})
endif
