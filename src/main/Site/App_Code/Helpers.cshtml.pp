﻿@helper NotificationRequired()
{
    <p>
        <small>Campos marcado(s) com <span class="required">*</span> são de preenchimento obrigatório.</small>
    </p>
}
@helper ActionForSave(string backUrl)
{
    <p class="actions">
        <input type="submit" value="Salvar" title="Salvar informações" class="button" />
        <a href="@Href(backUrl)" title="Voltar" class="back">Voltar</a>
    </p>     
}
@helper ActionForEdit(string url)
{
    <a href="@Href(url)" title="Editar" class="edit">
        <img src="@Href("~/content/manager/images/pencil.png")" alt="Editar" />
    </a>    
}
@helper ActionForDelete(string message, string url, bool delete)
{
    <a href="@(delete ? Href(url) : "#")" class="delete" title="Excluir" data-message="@message" data-delete="@delete.ToString().ToLower()">
        <img src="@Href("~/content/manager/images/icons/cross.png")" alt="Excluir" />
    </a>   
}

@helper ActionForDelete(string message, string url)
{
    @ActionForDelete(message, url, true)
}

@helper Modules($rootnamespace$.Models.UserProfile profile, IList<$rootnamespace$.Models.Module> modules)
{
    if (modules.Count > 0)
    { 
    <ul>
        @foreach (var module in modules)
        {
            <li @(module.Childs.Count > 0 ? "class=\"parent\"" : "") data-module="@module.Id">
                <label>
                    @if (profile.HasAccess(module))
                    {
                        <input type="checkbox" value="@module.Id" checked="checked" />    
                    }
                    else
                    {
                        <input type="checkbox" value="@module.Id" />
                    }
                    @module.Name
                    @if (module.Functionalities.Count > 0)
                    {
                        <a href="#" title="Permissões" class="permission" data-module="@module.Id">
                            <img src="@Href("~/content/manager/images/icons/lock.png")" alt="Permissões" width="16" height="16" />
                        </a>
                    }
                </label>
                @if (module.Functionalities.Count > 0)
                {
                    <div id="permission-modal-@module.Id" style="display: none;" data-module="@module.Id">
                        @foreach (var functionality in module.Functionalities)
                        {
                            <p>
                                <label>
                                    @if (profile.HasAccess(functionality))
                                    {
                                        <input type="checkbox" class="permission" value="@functionality.Id" checked="checked" />
                                    }
                                    else
                                    {
                                        <input type="checkbox" class="permission" value="@functionality.Id" />
                                    }
                                    @functionality.Name
                                </label>
                            </p>
                        }
                    </div>
                }
                @Modules(profile, module.Childs)
            </li>
        }
    </ul>
    }
}