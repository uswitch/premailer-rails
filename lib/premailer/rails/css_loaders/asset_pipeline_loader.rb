class Premailer
  module Rails
    module CSSLoaders
      module AssetPipelineLoader
        extend self

        def load(url)
          if asset_pipeline_present?
            file = file_name(url)
            asset = ::Rails.application.assets.find_asset(file)
            asset.to_s if asset
          end
        end

        def asset_pipeline_present?
          defined?(::Rails) and ::Rails.application.respond_to?(:assets)
        end

        def file_name(url)
          prefix = [::Rails.configuration.relative_url_root, ::Rails.configuration.assets.prefix, "/"].reject(&:blank?).join
          URI(url).path
            .sub(prefix, '')
            .sub(/-(\h{32}|\h{64})\.css$/, '.css')
        end
      end
    end
  end
end
