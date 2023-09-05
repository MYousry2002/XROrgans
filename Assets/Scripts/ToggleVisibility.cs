using UnityEngine;
using UnityEngine.UI;

public class ToggleVisibility : MonoBehaviour
{
    public GameObject objectToControl; // The object that you want to show/hide

    // The function to toggle the object's visibility
    public void ToggleObjectVisibility(bool toggleStatus)
    {
        objectToControl.SetActive(toggleStatus);
    }
}