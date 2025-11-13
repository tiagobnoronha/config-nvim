local jdtls = require 'jdtls'

-- Determine o sistema operacional
local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

-- Caminho para o jdtls instalado pelo Mason
local jdtls_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'
local lombok_path = jdtls_path .. '/lombok.jar'

-- Configuração do jdtls
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',

    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    -- Configuração do Lombok
    '-javaagent:' .. lombok_path,

    '-jar',
    vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    jdtls_path .. '/config_linux', -- ou config_mac / config_win

    '-data',
    workspace_dir,
  },

  root_dir = jdtls.setup.find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },

  settings = {
    java = {
      eclipse = {

        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
      },
      maven = {
        downloadSources = true,
      },

      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',

        'java.util.Objects.requireNonNullElse',

        'org.mockito.Mockito.*',
      },
    },
    contentProvider = { preferred = 'fernflower' },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {

        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },

      useBlocks = true,
    },
  },

  init_options = {
    bundles = {},
  },
}

-- Configurar capabilities (integração com nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
config.capabilities = capabilities

-- Iniciar ou anexar ao jdtls
jdtls.start_or_attach(config)
